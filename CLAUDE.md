# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`UserRequest` is a legacy Java EE web app (NetBeans project, Servlet 3.1 / JSP) for Bangkok Ranch's ICT department. It is the "user access request" system that sits in front of the Infor M3 ERP running on an IBM i (AS/400) host: staff request or change M3 application/role access, ICT staff approve/create the accounts, and admins manage staff records, password resets, and access reports. Deployed at context path `/UserRequest`.

## Build & deploy

This is an Ant/NetBeans project, not a real Maven build — `pom.xml` exists but only declares a `junit` test dependency and does not reflect the actual source layout or dependencies; ignore it for building.

- Build/package: `ant -f build.xml` (delegates to `nbproject/build-impl.xml`). Produces `dist/UserRequest.war`.
- Source root is `src/java` (not `src/main/java`), compiled into `build/web/WEB-INF/classes`.
- Web root is `web/` — JSPs, `web/WEB-INF/web.xml`, `web/META-INF/context.xml`, and all third-party JS/CSS live directly under `web/assets`, `web/fonts`, `web/dist`.
- All Java dependencies are vendored jars under `web/WEB-INF/lib` and referenced by path in `nbproject/project.properties` (`file.reference.*` / `javac.classpath`) — there is no dependency manager. To add a library, drop the jar in `web/WEB-INF/lib` and register it in `nbproject/project.properties`.
- Target runtime is Tomcat (`j2ee.server.type=Tomcat`, `j2ee.platform=1.7-web`), Java source/target 1.8.
- No test suite exists (`test.src.dir=test` points at a directory that isn't present) and there is no linter configured. Verification in practice means building the WAR and exercising the JSP flows manually against the real AS/400 — you generally cannot run this locally without VPN/network access to `192.200.9.190` (AS/400) and `192.200.9.111` (SQL Server).

## Architecture

### Backend: `Sync` servlet as a single AJAX dispatcher

`com.br.api.app.get.Sync` (`/Sync`) is the app's entire API surface. `doGet` dispatches read operations and `doPost` dispatches writes, both via long `if (request.getParameter("page").equals("X"))` chains — there is no routing framework. Each branch calls one static method on a DB access class and prints its return value (JSON or plain string) straight to the response writer. To add a new AJAX operation: add a data-access method, then add one more `else if` branch in `Sync`, then call `Sync?page=YourNewPage` from a JSP.

Other standalone servlets (each independently mapped in `web/WEB-INF/web.xml`): `Login`, `Logout`, `Report` (JasperReports), plus unmapped-but-present ones under `com.br.api.app.get` (`ChangePW`, `ResetNewPW`, `UploadFile`, `UploadSignature`, `UploadStaff`, `UnlockUserDisable`, `sendmail`/`Send_mail`).

### Data access layers (`com.br.api.app`)

- `SelectDB2` / `InsertDB2` / `UpdateDB2` / `DeleteDB2` — one static method per query or mutation. Each method opens its own `Connection` via `ConnectDB2`, builds SQL by **string concatenation** (not parameterized — this is pervasive throughout the codebase, treat as an existing pattern rather than something to silently "fix" unless asked), and hand-builds a `org.codehaus.jettison.json.JSONArray` from the `ResultSet` by manual column-index `getString(n)` calls. Follow this exact shape when adding new queries so `Sync` and the JSPs can consume them consistently.
- `Utility` — thin wrappers that call `SelectDB2`/`InsertDB2` and wrap the result in a `{"data": [...]}` / `{"status":"404","message":"..."}` envelope; also holds the RSA encrypt/decrypt helpers (`genRSAKeyPairAndSaveToFile`, `getmimecode`/`getdecodemime`) used to build the tokenized password-reset links emailed to users.
- `JasperGen` / `Genreport` / `BlobGen` — JasperReports generation, backing the `Report` servlet and `web/Report/ReportResign.jrxml`/`.jasper`.
- `com.br.api.as400.CreateUserAS400` — creates AS/400 (M3) user profiles.
- `com.br.utility.Constant` — single point where PROD vs TEST target environment is chosen (AS/400 host/port, DB2 library names `dbname`/`dbM3Name`, M3 web URL). Switching environments means commenting/uncommenting the PROD vs TEST block in this file — there is no profile/property-file mechanism.

### `ConnectDB2` — connection strategies

`com.br.api.app.connect.ConnectDB2` has several near-duplicate connection methods, each for a different purpose — check which one a caller needs before reusing:
- `ConnectionDB()` — the app's own service account (`M3SRVICT`) against AS/400 DB2, used by almost all `SelectDB2`/`InsertDB2`/etc. methods.
- `LoginDB(user, pass)` — signs on to AS/400 as the *actual requesting user's* credentials; used only by `Login` to authenticate, and its failure exceptions are pattern-matched by message text (e.g. `"Bad return code from signon info: 0x3000d"` = expired password) to produce user-facing login errors.
- `RUNConnectionDB()` — same AS/400 target via the `jtopenlite` driver instead of `jt400`.
- `servers111()` — separate SQL Server database (`XIQMAOWADB`) unrelated to the AS/400 M3 data.

### Frontend: JSP shell + jQuery fragment loading

`web/index.jsp` is a persistent layout shell (nav bar) that swaps content by AJAX-loading a fragment JSP into `#vSection`: `$("#vSection").load("./programs/<page>.jsp")`, where `<page>` comes from the `?page=` query parameter (defaults to `RequestUser`). Each fragment under `web/programs/*.jsp` is a self-contained mini-page that itself calls `Sync?page=...` (via jQuery) to fetch/submit data, often rendered with **jsGrid** for editable tables, Select2 for dropdowns, and Bootstrap 3 for layout. There is no client-side framework/bundler — JS is inline in the JSPs plus vendored libraries in `web/assets`.

Session state set at login (`Login` servlet) and read throughout the JSPs/servlets: `namereq` (M3 username), `ST_CODE` (employee code), `ST_COSTC` (cost center — `"S8"` unlocks the ICT-only menu section), `cono` (company number).

### Domain/workflow notes

- Requests live in `USR_REQUEST` (DB2 library `dbname`, i.e. `BRLDTA0100`), keyed by `USREQNO`/`USLINE`, with status codes in `USSTAT`: `0` not sent, `10` wait for create, `15` wait for acknowledge, `20` complete, `99` cancelled/deleted.
- Staff master data is `STAFFLIST` (`ST_CODE`, `ST_N6L3`/`ST_M3` = AS/400 user id, `ST_COSTC`, etc.).
- Role/authorization catalog tables are `APPCTL1`/`APPCTL2`/`APPCTL3`.
- Company/division reference data comes from M3's own `CMNDIV` table (library `M3FDBPRD`), joined in to resolve company names.
