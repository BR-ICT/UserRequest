/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.br.api.app;

import com.br.api.app.connect.ConnectDB2;
import static com.br.utility.Constant.dbM3Name;
import static com.br.utility.Constant.dbname;
import com.lowagie.tools.split_pdf;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import org.apache.tomcat.util.codec.binary.Base64;
import org.codehaus.jettison.json.JSONArray;

/**
 *
 * @author Wattana
 */
public class SelectDB2 {

    public static JSONArray getCompany() throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT CCCONO,CCDIVI,CCCONM,'\"'|| TRIM(CCCONO) || ' : ' || TRIM(CCDIVI) || ' : ' || TRIM(CCCONM) || '\"' AS COMPANY\n"
                        + "FROM M3FDBPRD.CMNDIV\n"
                        + "WHERE CCDIVI != ''\n"
                        + "ORDER BY CCCONO";
                System.out.println("SelectCompany\n" + query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("CCCONO", mRes.getString(1).trim());
                    mMap.put("CCDIVI", mRes.getString(2).trim());
                    mMap.put("CCCONM", mRes.getString(3).trim());
                    mMap.put("COMPANY", mRes.getString(4).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray getRole(String isitgroupby, String isitappby, String groupby, String app) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();
        String query = "";

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                if (isitgroupby.equals("true")) {
                    query = "SELECT DISTINCT CTL2_REM1 FROM " + dbname + ".APPCTL2\n"
                            + "WHERE CTL2_GRP = '" + groupby + "'";
                } else {
                    query = "SELECT  DISTINCT CTL2_REM1 FROM " + dbname + ".APPCTL2\n"
                            + "LEFT JOIN " + dbname + ".APPCTL3 ON\n"
                            + "CTL2_GRP = CTL3_GRP\n"
                            + "WHERE CTL3_CODE = '" + app + "'\n"
                            + "AND CTL3_TYPE = 'APP'";
                }

                System.out.println("SelectCompany\n" + query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("CTL2_REM1", mRes.getString(1).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray getGroupapp(String authorreport) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT DISTINCT CTL2_NAME,CTL2_GRP FROM " + dbname + ".APPCTL3\n"
                        + "LEFT JOIN " + dbname + ".APPCTL2\n"
                        + "ON CTL2_GRP = CTL3_GRP\n"
                        + "WHERE CTL2_GRP IS NOT NULL\n"
                        + "AND CTL3_TYPE = '" + authorreport + "'";
                System.out.println("SelectCompany\n" + query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("CTL2_NAME", mRes.getString(1).trim());
                    mMap.put("CTL2_GRP", mRes.getString(2).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray GET_REQNO() throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();
        Locale.setDefault(Locale.US);
        Date d = new Date();
        SimpleDateFormat A = new SimpleDateFormat("yyyyMMdd");
        String USREQDT = A.format(d);

        String year = USREQDT.substring(2, 4);
        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT COALESCE((SUBSTR('" + USREQDT + "',3,2) || MAX(SUBSTR(USREQNO,3,7))+1),(SUBSTR('" + USREQDT + "',3,2)||'0001')) AS reqno \n"
                        + "FROM " + dbname + ".USR_REQUEST\n"
                        + "WHERE SUBSTR(USREQDT,3,2) =  '" + year + "'";
//                String query = "SELECT SUBSTR('" + USREQDT + "',3,2) || MAX(SUBSTR(USREQNO,3,7))+1 AS reqno \n"
//                        + "FROM " + dbname + ".USR_REQUEST\n"
//                        + "WHERE SUBSTR(USREQDT,3,2) =  '" + year + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("reqno", mRes.getString(1).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    NumberFormat df = new DecimalFormat("#,##0.00");

    public static int checkExistUserbyempcode(String empcode) throws Exception {

        int userCount = 0;
        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT  COUNT(TRIM(ST_N6L3)) AS usercount FROM " + dbname + ".STAFFLIST s\n"
                        + "                       WHERE  ST_CODE = '" + empcode.trim() + "'\n"
                        + "                       AND ST_N6L3  != '#N/A'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();

                    userCount = mRes.getInt("usercount");

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return userCount;

    }

    public static JSONArray checkExistRole(String cono, String usercode, String app, String groupapp, String role, String mode, String apporrep) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();
        String query = "";
        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                if (apporrep.equals("APP")) {
                    if (mode.equals("Byapp")) {
                        query = "SELECT COUNT(CTL_UID) as AMOUNT FROM " + dbname + ".APPCTL1\n"
                                + "LEFT JOIN BRLDTA0100.STAFFLIST ON CTL_UID = ST_N6L3\n"
                                + "LEFT JOIN BRLDTA0100.APPCTL3 ON \n"
                                + "CTL3_CODE = CTL_CODE\n"
                                + "WHERE ST_CODE = '" + usercode + "'\n"
                                + "AND CTL_REM = '" + role + "' and CTL_CODE = '" + app + "'\n"
                                + "AND CTL_CONO = '" + cono + "' AND CTL3_TYPE ='" + apporrep + "'";
                    } else {
                        query = "SELECT COUNT(CTL_UID) as AMOUNT  FROM " + dbname + ".APPCTL1\n"
                                + "LEFT JOIN BRLDTA0100.APPCTL3 ON \n"
                                + "CTL3_CODE = CTL_CODE\n"
                                + "LEFT JOIN BRLDTA0100.STAFFLIST ON CTL_UID = ST_N6L3\n"
                                + "WHERE ST_CODE = '" + usercode + "' \n"
                                + "AND CTL_REM = '" + role + "' and  CTL_GRP = '" + groupapp + "'\n"
                                + "AND CTL_CONO = '" + cono + "' AND CTL3_TYPE ='" + apporrep + "'";
                    }

                } else if (apporrep.equals("REP")) {
                    if (mode.equals("Byapp")) {
                        query = "SELECT COUNT(CTL_UID) as AMOUNT FROM " + dbname + ".APPCTL1\n"
                                + "LEFT JOIN BRLDTA0100.STAFFLIST ON CTL_UID = ST_N6L3\n"
                                + "LEFT JOIN BRLDTA0100.APPCTL3 ON \n"
                                + "CTL3_CODE = CTL_CODE\n"
                                + "WHERE ST_CODE = '" + usercode + "'\n"
                                + "AND CTL_CODE = '" + app + "'\n"
                                + "AND CTL_CONO = '" + cono + "' AND CTL3_TYPE ='" + apporrep + "'";
                    } else {
                        query = "SELECT COUNT(CTL_UID) as AMOUNT FROM " + dbname + ".APPCTL1\n"
                                + "LEFT JOIN BRLDTA0100.APPCTL3 ON \n"
                                + "CTL3_CODE = CTL_CODE\n"
                                + "LEFT JOIN BRLDTA0100.STAFFLIST ON CTL_UID = ST_N6L3\n"
                                + "WHERE ST_CODE = '" + usercode + "' \n"
                                + "and  CTL_GRP = '" + groupapp + "'\n"
                                + "AND CTL_CONO = '" + cono + "' AND CTL3_TYPE ='" + apporrep + "'";
                    }
                }
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("AMOUNT", mRes.getString(1).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray authorizedisplay(String USUREQ) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT CTL_CODE,TRIM(CCCONO) || ' : ' || TRIM(CCDIVI) || ' : ' || TRIM(CCCONM) || '\"' AS COMPANY,  CTL_GRP, CTL_SEQ, CTL_STS, CTL_UID, CTL_REM  \n"
                        + "FROM " + dbname + ".APPCTL1\n"
                        + "LEFT JOIN M3FDBPRD.CMNDIV\n"
                        + "ON CTL_CONO = CCCONO\n"
                        + "WHERE CTL_UID = '" + USUREQ + "'\n"
                        + "AND CCDIVI NOT IN ('','120','130','401')\n"
                        + "ORDER BY CTL_CODE,CTL_CONO,CTL_GRP,CTL_CODE";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("CTL_CODE", mRes.getString(1).trim());
                    mMap.put("COMPANY", mRes.getString(2).trim());
                    mMap.put("CTL_GRP", mRes.getString(3).trim());
                    mMap.put("CTL_SEQ", mRes.getString(4).trim());
                    mMap.put("CTL_STS", mRes.getString(5).trim());
                    mMap.put("CTL_UID", mRes.getString(6).trim());
                    mMap.put("CTL_REM", mRes.getString(7).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static int checkExistUser(String username) throws Exception {

        int userCount = 0;
        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT  COUNT(TRIM(ST_N6L3)) AS usercount FROM " + dbname + ".STAFFLIST s\n"
                        + "WHERE  ST_N6L3 = '" + username.trim() + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();

                    userCount = mRes.getInt("usercount");

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return userCount;

    }

    public static JSONArray Company() throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT CCCONO,CCDIVI,RTRIM(CCTX15) as CCTX15,'\"'|| TRIM(CCCONO) || ' : ' || TRIM(CCDIVI) || ' : ' || TRIM(CCCONM) || '\"' AS COMPANY\n"
                        + "FROM M3FDBPRD.CMNDIV\n"
                        + "WHERE CCDIVI NOT IN ('','120','130','401')\n"
                        + "ORDER BY CCCONO";
//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("CCCONO", mRes.getString(1).trim());
                    mMap.put("CCDIVI", mRes.getString(2).trim());
                    mMap.put("CCTX15", mRes.getString(3).trim());
                    mMap.put("COMPANY", mRes.getString(4).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray costcenter(String cono) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT DISTINCT TRIM(S2AITM) AS S2AITM, TRIM(S2TX15) AS COSTCENTER \n"
                        + "FROM M3FDBPRD.FSTLIN a, M3FDBPRD.FCHACC b \n"
                        + "WHERE S2CONO = '10' \n"
                        + "AND S2DIVI = '101' \n"
                        + "AND S2SLVL = '1' \n"
                        + "AND b.EACONO = a.S2CONO \n"
                        + "AND b.EADIVI = a.S2DIVI \n"
                        + "AND b.EAAITP = '2' \n"
                        + "AND b.EALCCD = '0' \n"
                        + "AND b.EAAITM = a.S2AITM \n"
                        + "AND S2STID IN (SELECT TRIM(S2AITM) \n"
                        + "FROM M3FDBPRD.FSTLIN a, M3FDBPRD.FSTDEF b \n"
                        + "--WHERE S2CONO = '10' \n"
                        + "--AND S2DIVI = '101' \n"
                        + "WHERE S2SLVL = '2' \n"
                        + "--AND S2STID = '' \n"
                        + "AND S1CONO = a.S2CONO \n"
                        + "AND S1DIVI = a.S2DIVI \n"
                        + "AND S1STID = a.S2AITM \n"
                        + "ORDER BY S2AITM) \n"
                        + "ORDER BY S2AITM";

//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("eaaitm", mRes.getString(1).trim());
                    mMap.put("eatx15", mRes.getString(2).trim());

                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray MailCreator() throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "Select ST_ENAME,ST_EMAIL\n"
                        + "FROM " + dbname + ".STAFFLIST"
                        + "\n Where ST_COSTC = 'S8'\n"
                        + "AND ST_STS = '20' ";
//                        + "\n and ST_CODE IN ('0103464','010','0102906','0100694','0100530')";
//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("ST_ENAME", mRes.getString(1).trim());
                    mMap.put("ST_EMAIL", mRes.getString(2).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray Costcenter(String cono, String divi) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT TRIM(EAAITM) as EAAITM ,TRIM(EATX40) as EATX40\n"
                        + "FROM M3FDBTST.FCHACC\n"
                        + "WHERE EACONO = '" + cono + "'\n"
                        + "  AND EADIVI = '" + divi + "'\n"
                        + "  AND EALCCD = 0\n"
                        + "  AND EAAITP = 2\n"
                        + "  ORDER BY EAAITM";
//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("EAAITM", mRes.getString(1).trim());
                    mMap.put("EATX40", mRes.getString(2).trim());

                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public ResultSet SearchEmail(String cono, String divi, String ename) {

        try {
            ResultSet RsEmailTemplate;
            Connection conn = ConnectDB2.ConnectionDB();
            Statement sta = conn.createStatement();
            String sql = "SELECT US_NAME,US_ENAME,US_CONO,US_DIVI\n"
                    + "FROM " + dbname + ".M3_USERNEW \n"
                    + "WHERE US_LOGIN = '" + ename + "'\n";
//                    + "and US_CONO = '" + cono + "'\n"
//                    + "and US_DIVI = '" + divi + "'";
            RsEmailTemplate = sta.executeQuery(sql);
            return RsEmailTemplate;

        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return null;
    }

    public static JSONArray Table_USRREQ(String USREQNO) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT USREQNO, USLINE, USCOMP, USCODE ,USNAME1, USNAME2,"
                        + " USMAIL, USCOSTC, USGROUP, USTYPE, USLIKE,"
                        + " USAFUNC, USDFUNC,  USREQDT, USEMCRE,COALESCE(trim(USAPP),'') as USAPP,COALESCE(trim(USGROUPAPP),'') as USGROUPAPP,COALESCE(trim(USROLE),'') as USROLE\n"
                        + "FROM " + dbname + ".USR_REQUEST\n"
                        + "WHERE USREQNO = '" + USREQNO.trim() + "'\n"
                        + "ORDER BY USLINE ASC";
//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("USREQNO", mRes.getString(1).trim());
                    mMap.put("USLINE", mRes.getString(2).trim());
                    mMap.put("USCOMP", mRes.getString(3).trim());
                    mMap.put("USCODE", mRes.getString(4).trim());
                    mMap.put("USNAME1", mRes.getString(5).trim());
                    mMap.put("USNAME2", mRes.getString(6).trim());
                    mMap.put("USMAIL", mRes.getString(7).trim());
                    mMap.put("USCOSTC", mRes.getString(8).trim());
                    mMap.put("USGROUP", mRes.getString(9).trim());
                    mMap.put("USTYPE", mRes.getString(10).trim());
                    mMap.put("USLIKE", mRes.getString(11).trim());
                    mMap.put("USAFUNC", mRes.getString(12).trim());
                    mMap.put("USDFUNC", mRes.getString(13).trim());
                    mMap.put("USREQDT", mRes.getString(14).trim());
                    mMap.put("USEMCRE", mRes.getString(15).trim());
                    mMap.put("USAPP", mRes.getString(16).trim());
                    mMap.put("USGROUPAPP", mRes.getString(17).trim());
                    mMap.put("USROLE", mRes.getString(18).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray Request_List() throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT DISTINCT USREQNO,USLINE, USNAME1, USNAME2,"
                        + " USMAIL, USCOSTC, USGROUP, USTYPE, USLIKE,"
                        + " USAFUNC, USDFUNC,  USREQDT, USCODE, USREMK, TRIM(SUBSTRING(USNAME1,1,6)) || '_' || TRIM(SUBSTRING(USNAME2,1,3)) AS USERNAME,USEMCRE\n"
                        + ",SUBSTRING(USREQDT,1,4) || '-' || SUBSTRING(USREQDT,5,2) || '-' || SUBSTRING(USREQDT,7,2) AS DATE,ST_N6L3,USUREQ\n"
                        + ",COALESCE(trim(USAPP),'') as USAPP,COALESCE(trim(USGROUPAPP),'') as USGROUPAPP,COALESCE(trim(USROLE),'') as USROLE\n"
                        + "FROM " + dbname + ".USR_REQUEST," + dbname + ".STAFFLIST\n"
                        + "WHERE USSTAT = '10'\n"
                        + "AND USCODE = ST_CODE\n"
                        + "ORDER BY USREQNO";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("USREQNO", mRes.getString(1).trim());
                    mMap.put("USLINE", mRes.getString(2).trim());
//                    mMap.put("USCOMP", mRes.getString(3).trim());
                    mMap.put("USNAME1", mRes.getString(3).trim());
                    mMap.put("USNAME2", mRes.getString(4).trim());
                    mMap.put("USMAIL", mRes.getString(5).trim());
                    mMap.put("USCOSTC", mRes.getString(6).trim());
                    mMap.put("USGROUP", mRes.getString(7).trim());
                    mMap.put("USTYPE", mRes.getString(8).trim());
                    mMap.put("USLIKE", mRes.getString(9).trim());
                    mMap.put("USAFUNC", mRes.getString(10).trim());
                    mMap.put("USDFUNC", mRes.getString(11).trim());
                    mMap.put("USREQDT", mRes.getString(12).trim());
                    mMap.put("USCODE", mRes.getString(13).trim());
                    mMap.put("USREMK", mRes.getString(14).trim());
                    mMap.put("USERNAME", mRes.getString(15).trim());
                    mMap.put("USEMCRE", mRes.getString(16).trim());
                    mMap.put("DATE", mRes.getString(17).trim());
                    mMap.put("STN6L3", mRes.getString(18).trim());
                    mMap.put("USUREQ", mRes.getString(19).trim());
                    mMap.put("USAPP", mRes.getString(20).trim());
                    mMap.put("USGROUPAPP", mRes.getString(21).trim());
                    mMap.put("USROLE", mRes.getString(22).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray Request_List2(String USUREQ) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT DISTINCT USREQNO, USNAME1, USNAME2,\n"
                        + " USMAIL, USCOSTC, USGROUP, USTYPE, USLIKE,\n"
                        + " USAFUNC, USDFUNC,  USREQDT, USCODE, USREMK, TRIM(SUBSTRING(USNAME1,1,6)) || '_' || TRIM(SUBSTRING(USNAME2,1,3)) AS USERNAME,USEMCRE\n"
                        + ",SUBSTRING(USREQDT,1,4) || '-' || SUBSTRING(USREQDT,5,2) || '-' || SUBSTRING(USREQDT,7,2) AS DATE\n"
                        + ",CASE WHEN USSTAT = 0 THEN 'Not send' WHEN USSTAT = 10 THEN 'Wait for create' WHEN USSTAT = 15 THEN 'Wait for acknowledge' WHEN USSTAT = 20 THEN 'Complete' ELSE '-' END AS Status \n"
                        + ",COALESCE(trim(USAPP),'') as USAPP,COALESCE(trim(USGROUPAPP),'') as USGROUPAPP,COALESCE(trim(USROLE),'') as USROLE\n"
                        + "FROM " + dbname + ".USR_REQUEST\n"
                        + "WHERE USSTAT IN  ('00','15')\n"
                        + "and USUREQ = '" + USUREQ + "'\n"
                        + "ORDER BY USREQNO desc";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("USREQNO", mRes.getString(1).trim());
//                    mMap.put("USLINE", mRes.getString(2).trim());
//                    mMap.put("USCOMP", mRes.getString(3).trim());
                    mMap.put("USNAME1", mRes.getString(2).trim());
                    mMap.put("USNAME2", mRes.getString(3).trim());
                    mMap.put("USMAIL", mRes.getString(4).trim());
                    mMap.put("USCOSTC", mRes.getString(5).trim());
                    mMap.put("USGROUP", mRes.getString(6).trim());
                    mMap.put("USTYPE", mRes.getString(7).trim());
                    mMap.put("USLIKE", mRes.getString(8).trim());
                    mMap.put("USAFUNC", mRes.getString(9).trim());
                    mMap.put("USDFUNC", mRes.getString(10).trim());
                    mMap.put("USREQDT", mRes.getString(11).trim());
                    mMap.put("USCODE", mRes.getString(12).trim());
                    mMap.put("USREMK", mRes.getString(13).trim());
                    mMap.put("USERNAME", mRes.getString(14).trim());
                    mMap.put("USEMCRE", mRes.getString(15).trim());
                    mMap.put("DATE", mRes.getString(16).trim());
                    mMap.put("Status", mRes.getString(17).trim());
                    mMap.put("USAPP", mRes.getString(18).trim());
                    mMap.put("USGROUPAPP", mRes.getString(19).trim());
                    mMap.put("USROLE", mRes.getString(20).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray TrackStatus() throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
//                String query = "SELECT USREQNO, USLINE, USCOMP, USNAME1, USNAME2,"
//                        + " USMAIL, USCOSTC, USGROUP, USTYPE, USLIKE,"
//                        + " USAFUNC, USUREQ,  SUBSTRING(USREQDT,1,4) || '-' || SUBSTRING(USREQDT,5,2) || '-' || SUBSTRING(USREQDT,7,2) AS USREQDT, USCODE, USREMK, USEMCRE\n"
//                        + ",CASE WHEN USSTAT = 0 THEN 'Not send' WHEN USSTAT = 10 THEN 'Wait for create' WHEN USSTAT = 15 THEN 'Wait for acknowledge' WHEN USSTAT = 20 THEN 'Complete' ELSE '-' END AS USSTAT \n"
//                        + "FROM " + dbname + ".USR_REQUEST\n"
//                        + "WHERE USSTAT != '99'\n"
//                        + "ORDER BY USREQNO DESC,USLINE";

                String query = "SELECT USREQNO, USLINE, USCOMP, USNAME1, USNAME2,COALESCE(B.ST_POSITON,'') AS POSI,\n"
                        + " USMAIL, USCOSTC, USGROUP, USTYPE, USLIKE,\n"
                        + " USAFUNC, USUREQ,COALESCE(C.ST_POSITON,'') AS REQUESTERPOSITION,  SUBSTRING(USREQDT,1,4) || '-' || SUBSTRING(USREQDT,5,2) || '-' || SUBSTRING(USREQDT,7,2) AS USREQDT, USCODE, USREMK, USEMCRE\n"
                        + ",CASE WHEN USSTAT = 0 THEN 'Not send' WHEN USSTAT = 10 THEN 'Wait for create' WHEN USSTAT = 15 THEN 'Wait for acknowledge' WHEN USSTAT = 20 THEN 'Complete' ELSE '-' END AS USSTAT \n"
                        + "FROM " + dbname + ".USR_REQUEST A\n"
                        + "LEFT JOIN " + dbname + ".STAFFLIST B ON\n"
                        + "A.USCODE = B.ST_CODE\n"
                        + "LEFT JOIN " + dbname + ".STAFFLIST C ON\n"
                        + "A.USUREQ = C.ST_N6L3\n"
                        + "WHERE USSTAT != '99'\n"
                        + "ORDER BY USREQNO DESC,USLINE";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("USREQNO", mRes.getString(1).trim());
                    mMap.put("USLINE", mRes.getString(2).trim());
                    mMap.put("USCOMP", mRes.getString(3).trim());
                    mMap.put("USNAME1", mRes.getString(4).trim());
                    mMap.put("USNAME2", mRes.getString(5).trim());
                    mMap.put("POSITION1", mRes.getString(6).trim());
                    mMap.put("USMAIL", mRes.getString(7).trim());
                    mMap.put("USCOSTC", mRes.getString(8).trim());
                    mMap.put("USGROUP", mRes.getString(9).trim());
                    mMap.put("USTYPE", mRes.getString(10).trim());
                    mMap.put("USLIKE", mRes.getString(11).trim());
                    mMap.put("USAFUNC", mRes.getString(12).trim());
                    mMap.put("USUREQ", mRes.getString(13).trim());
                    mMap.put("POSITION2", mRes.getString(14).trim());
                    mMap.put("USREQDT", mRes.getString(15).trim());
                    mMap.put("USCODE", mRes.getString(16).trim());
                    mMap.put("USREMK", mRes.getString(17).trim());

                    String[] Creator = mRes.getString(18).trim().split("@");
                    mMap.put("USEMCRE", Creator[0].toUpperCase());
                    mMap.put("USSTAT", mRes.getString(19).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray GetMaxLine(String USREQNO) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT MAX(USLINE)+1 AS LINE\n"
                        + "FROM " + dbname + ".USR_REQUEST\n"
                        + "WHERE USREQNO = '" + USREQNO + "'";
//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("LINE", mRes.getString(1).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray Data_Acknowledge(String USREQNO) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT USREQNO, USLINE, USCOMP, USCODE ,USNAME1, USNAME2, USMAIL, USGROUP, USTYPE,\n"
                        + "USLIKE, USAFUNC, USDFUNC,  USREQDT, USEMCRE,\n"
                        + "TRIM(SUBSTRING(USNAME1,1,6)) || '_' || TRIM(SUBSTRING(USNAME2,1,3)) AS username, CCCONO || ' : ' || CCTX15 AS COMPANY\n"
                        + ",USREMK,USCREBY\n"
                        + ",COALESCE(trim(USAPP),'') as USAPP,COALESCE(trim(USGROUPAPP),'') as USGROUPAPP,COALESCE(trim(USROLE),'') as USROLE\n"
                        + "FROM " + dbname + ".USR_REQUEST\n"
                        + "LEFT JOIN M3FDBPRD.CMNDIV ON CCDIVI NOT IN ('120','130','') AND CCCONO = USCOMP\n"
                        + "LEFT JOIN m3fdbprd.fchacc ON eaaitp =  2 AND USCOSTC = EAAITM AND USCOMP = EACONO\n"
                        + "WHERE USREQNO = '" + USREQNO.trim() + "'\n"
                        + "and USSTAT = '15'";

//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("USREQNO", mRes.getString(1).trim());
                    mMap.put("USLINE", mRes.getString(2).trim());
                    mMap.put("USCOMP", mRes.getString(3).trim());
                    mMap.put("USCODE", mRes.getString(4).trim());
                    mMap.put("USNAME1", mRes.getString(5).trim());
                    mMap.put("USNAME2", mRes.getString(6).trim());
                    mMap.put("USMAIL", mRes.getString(7).trim());
                    mMap.put("USGROUP", mRes.getString(8).trim());
                    mMap.put("USTYPE", mRes.getString(9).trim());
                    mMap.put("USLIKE", mRes.getString(10).trim());
                    mMap.put("USAFUNC", mRes.getString(11).trim());
                    mMap.put("USDFUNC", mRes.getString(12).trim());
                    mMap.put("USREQDT", mRes.getString(13).trim());
                    mMap.put("USEMCRE", mRes.getString(14).trim());
                    mMap.put("username", mRes.getString(15).trim());
                    mMap.put("COMPANY", mRes.getString(16).trim());
                    mMap.put("USREMK", mRes.getString(17).trim());
                    mMap.put("USCREBY", mRes.getString(18).trim());
                    mMap.put("USAPP", mRes.getString(19).trim());
                    mMap.put("USGROUPAPP", mRes.getString(20).trim());
                    mMap.put("USROLE", mRes.getString(21).trim());

                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray DetailUser(String ST_CODE) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT  ST_CONO,ST_N6L3,  ST_EMAIL, ST_COSTC,"
                        + "ST_CODE, ST_EPNM, ST_ENAME, ST_ELNAME, ST_TPNM, "
                        + "ST_TNAME, ST_TLNAME\n"
                        + "FROM " + dbname + ".STAFFLIST\n"
                        + "where ST_CODE = '" + ST_CODE + "'";

//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("ST_CONO", mRes.getString(1).trim());
                    mMap.put("ST_N6L3", mRes.getString(2).trim());
                    mMap.put("ST_EMAIL", mRes.getString(3).trim());
                    mMap.put("ST_COSTC", mRes.getString(4).trim());
                    mMap.put("ST_CODE", mRes.getString(5).trim());
                    mMap.put("ST_EPNM", mRes.getString(6).trim());
                    mMap.put("ST_ENAME", mRes.getString(7).trim());
                    mMap.put("ST_ELNAME", mRes.getString(8).trim());
                    mMap.put("ST_TPNM", mRes.getString(9).trim());
                    mMap.put("ST_TNAME", mRes.getString(10).trim());
                    mMap.put("ST_TLNAME", mRes.getString(11).trim());

                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray getAppname(String authorreport) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                String query = "SELECT COALESCE(NULLIF(CTL3_NAME, ''),CTL3_CODE)"
                        + " AS CTL_CODE FROM " + dbname + ".APPCTL3\n"
                        + "WHERE CTL3_TYPE = '" + authorreport + "'";

//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();

//                    String year = ST_STDT.substring(0, 4).trim();
//                    String month = ST_STDT.substring(4, 6).trim();
//                    String day = ST_STDT.substring(6, 8).trim();
//                    ST_STDT = year + "-" + month + "-" + day;
                    mMap.put("Appname", mRes.getString("CTL_CODE").trim());
                    mJSonArr.put(mMap);
                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray Search(String ST_CODE) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {
                String dump = "ST_CODE";
                Statement stmt = conn.createStatement();
                String query = "SELECT ST_CONO, ST_N6L3, ST_M3, ST_EMAIL,"
                        + " ST_COSTC, ST_CODE, ST_EPNM, ST_ENAME, ST_ELNAME, "
                        + "ST_TPNM, ST_TNAME, ST_TLNAME, ST_POSITON, COALESCE(ST_LEVEL,'') AS ST_LEVEL,"
                        + "ST_DISM3, ST_DISMAIL, ST_STDT,ST_REDT, ST_SIGN, "
                        + "ST_STS\n"
                        + "FROM " + dbname + ".STAFFLIST\n"
                        + "where ST_CODE =  '" + ST_CODE + "'";

//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();

//                    String year = ST_STDT.substring(0, 4).trim();
//                    String month = ST_STDT.substring(4, 6).trim();
//                    String day = ST_STDT.substring(6, 8).trim();
//                    ST_STDT = year + "-" + month + "-" + day;
                    String ST_STDT = SetDate(mRes.getString(17).trim());
                    String ST_DISM3 = SetDate(mRes.getString(15).trim());
                    String ST_DISMAIL = SetDate(mRes.getString(16).trim());
                    String ST_REDT = SetDate(mRes.getString(18).trim());

                    mMap.put("ST_CONO", mRes.getString(1).trim());
                    mMap.put("ST_N6L3", mRes.getString(2).trim());
                    mMap.put("ST_M3", mRes.getString(3).trim());
                    mMap.put("ST_EMAIL", mRes.getString(4).trim());
                    mMap.put("ST_COSTC", mRes.getString(5).trim());

                    mMap.put("ST_CODE", mRes.getString(6).trim());
                    mMap.put("ST_EPNM", mRes.getString(7).trim());
                    mMap.put("ST_ENAME", mRes.getString(8).trim());
                    mMap.put("ST_ELNAME", mRes.getString(9).trim());
                    mMap.put("ST_TPNM", mRes.getString(10).trim());
                    mMap.put("ST_TNAME", mRes.getString(11).trim());
                    mMap.put("ST_TLNAME", mRes.getString(12).trim());
                    mMap.put("ST_POSITON", mRes.getString(13).trim());
                    mMap.put("ST_LEVEL", mRes.getString(14).trim());
                    mMap.put("ST_DISM3", ST_DISM3);
                    mMap.put("ST_DISEMAIL", ST_DISMAIL);
                    mMap.put("ST_STDT", ST_STDT);
                    mMap.put("ST_REDT", ST_REDT);

//                    System.out.print(ST_DISM3 + ST_DISMAIL + ST_STDT + ST_REDT);
                    mMap.put("ST_SIGN", "data:image/png;base64," + mRes.getString(19));
                    mMap.put("ST_STS", mRes.getString(20).trim());
                    mJSonArr.put(mMap);
                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray Check_Duplicate(String USREQNO, String USCOMP, String USCODE, String USGROUP, String USTYPE, String USAPP, String USGROUPAPP, String USROLE) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT COUNT(*) AS Duplicate\n"
                        + "FROM " + dbname + ".USR_REQUEST\n"
                        + "WHERE USREQNO = '" + USREQNO + "'\n"
                        + "AND USCOMP = '" + USCOMP + "'\n"
                        + "AND USCODE = '" + USCODE + "'\n"
                        + "AND USGROUP = '" + USGROUP + "'\n"
                        + "AND USTYPE = '" + USTYPE + "'\n"
                        + "AND USAPP = '" + USAPP + "'\n"
                        + "AND USGROUPAPP = '" + USGROUPAPP + "'\n"
                        + "AND USROLE = '" + USROLE + "'\n";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("Duplicate", mRes.getString(1).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray EmpCodeList() throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "Select RTRIM(ST_CODE) as ST_CODE\n"
                        + "from " + dbname + ".stafflist\n"
                        + "where ST_STS = '20'"
                        + "order by ST_CODE";
//                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    mMap.put("ST_CODE", mRes.getString(1).trim());
                    mJSonArr.put(mMap);

                }

            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static JSONArray getuseremail(String username) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT  ST_EMAIL FROM " + dbname + ".STAFFLIST WHERE  ST_CONO = '10' AND  ST_N6L3 = '" + username.trim() + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    String[] File = mRes.getString(1).split("-");
                    mMap.put("USFILE", File[0]);
                    mMap.put("TYPE", File[1]);
                    mJSonArr.put(mMap);
                }
            } else {
                System.out.println("Server can't connect.");
            }
        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return mJSonArr;
    }

    public static String getEncyptKey(String encrytcode) throws Exception {

        String prikey = "";
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT   EDPRIKEY FROM " + dbname + ".M3_STORAGEEMAILSEND WHERE   EDPUBKEY = '" + encrytcode + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    prikey = mRes.getString("EDPRIKEY");
                }

            } else {
                System.out.println("Server can't connect.");
            }
        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return prikey;
    }

    public static String getprikey(String encrytcode) throws Exception {

        String pkey = "";
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "        SELECT PRIKEY\n"
                        + "FROM M3FDBTST.LNGPIT\n"
                        + "\n"
                        + "WHERE  TSLGID  = '" + encrytcode + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    pkey = mRes.getString("PRIKEY");
                }
            } else {
                System.out.println("Server can't connect.");
            }
        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return pkey;
    }

    public static String getprivatekey(String encrytcode) throws Exception {

        String pkey = "";
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "      SELECT EDPRIKEY\n"
                        + "FROM " + dbname + ".M3_STORAGEEMAILSEND\n"
                        + "WHERE EDPUBKEY = '" + encrytcode + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    pkey = mRes.getString("EDPRIKEY");
                }
            } else {
                System.out.println("Server can't connect.");
            }
        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return pkey;
    }

    public static int Checkprivatekey(String encrytcode) throws Exception {

        int hasKey = 0;
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT   COUNT(EDPRIKEY)AS HASKEY FROM " + dbname + ".M3_STORAGEEMAILSEND WHERE   EDPUBKEY = '" + encrytcode + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    hasKey = mRes.getInt("HASKEY");
                }
            } else {
                System.out.println("Server can't connect.");
            }
        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return hasKey;
    }

    public static JSONArray checkusername(String username) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();
        int num = 0;
        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT  COUNT(ST_N6L3) AS num  FROM " + dbname + ".STAFFLIST WHERE  ST_STS = '20' AND  ST_N6L3 = '" + username.trim() + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    String[] File = mRes.getString(1).split("-");
                    mMap.put("num", File[0]);
                    mMap.put("username", username);
                    mJSonArr.put(mMap);

                }
            } else {
                System.out.println("Server can't connect.");
            }
        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return mJSonArr;
    }

    public static JSONArray ShowFile(String USREQNO, String USLINE) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();

        try {
            if (conn != null) {

                Statement stmt = conn.createStatement();
                String query = "SELECT USFILE FROM " + dbname + ".USR_REQUEST WHERE USREQNO = '" + USREQNO.trim() + "' and USLINE = '" + USLINE.trim() + "'";
                System.out.println(query);
                ResultSet mRes = stmt.executeQuery(query);

                while (mRes.next()) {
                    Map<String, Object> mMap = new HashMap<>();
                    String[] File = mRes.getString(1).split("-");
                    mMap.put("USFILE", File[0]);
                    mMap.put("TYPE", File[1]);
                    mJSonArr.put(mMap);
                }
            } else {
                System.out.println("Server can't connect.");
            }
        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return mJSonArr;
    }

    public static JSONArray CheckUserM3(String USCODE, String USCOMP, String USGROUP, String USTYPE, String USLIKE) throws Exception {

        JSONArray mJSonArr = new JSONArray();
        Connection conn = ConnectDB2.ConnectionDB();
        USGROUP = USGROUP.trim();
        try {
            if (conn != null) {
                if (USGROUP.equals("EPR") || USGROUP.equals("ESR")) {
                    Statement stmt = conn.createStatement();
                    String query = "SELECT COUNT(*) AS CheckUserM3\n"
                            + "FROM " + dbname + ".USR_REQUEST\n"
                            + "WHERE USCODE = '" + USCODE + "'\n"
                            + "AND USCOMP = '" + USCOMP + "'\n"
                            + "AND USGROUP = '" + USGROUP + "'\n"
                            + "AND USTYPE = 'New'\n"
                            + "AND USLIKE = '" + USLIKE + "'\n"
                            + "AND USSTAT IN ('10','15','20')";
                    System.out.println(query);
                    ResultSet mRes = stmt.executeQuery(query);
                    while (mRes.next()) {
                        Map<String, Object> mMap = new HashMap<>();
                        mMap.put("CheckUserM3", mRes.getString(1).trim());
                        mJSonArr.put(mMap);
                    }

                } else {
                    Statement stmt = conn.createStatement();
                    String query = "SELECT COUNT(*) AS CheckUserM3\n"
                            + "FROM " + dbname + ".USR_REQUEST\n"
                            + "WHERE USCODE = '" + USCODE + "'\n"
                            + "AND USCOMP = '" + USCOMP + "'\n"
                            + "AND USGROUP = '" + USGROUP + "'\n"
                            + "AND USTYPE = 'New'\n"
                            + "AND USSTAT IN ('10','15','20')";
                    System.out.println(query);
                    ResultSet mRes = stmt.executeQuery(query);
                    while (mRes.next()) {
                        Map<String, Object> mMap = new HashMap<>();
                        mMap.put("CheckUserM3", mRes.getString(1).trim());
                        mJSonArr.put(mMap);
                    }
                }
            } else {
                System.out.println("Server can't connect.");
            }

        } catch (SQLException sqle) {
            throw sqle;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.close();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return mJSonArr;

    }

    public static String SetDate(String date) {

        String Newdate = "";
        String year = "";
        String month = "";
        String day = "";

        if (date.equals("0")) {
            date = "00000000";
            year = date.substring(0, 4).trim();
            month = date.substring(4, 6).trim();
            day = date.substring(6, 8).trim();
            Newdate = year + "-" + month + "-" + day;
            return Newdate;
        } else {
            date = date;
            year = date.substring(0, 4).trim();
            month = date.substring(4, 6).trim();
            day = date.substring(6, 8).trim();
            Newdate = year + "-" + month + "-" + day;
            return Newdate;
        }

    }

}
