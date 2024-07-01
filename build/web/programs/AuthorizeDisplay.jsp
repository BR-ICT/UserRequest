<%-- 
    Document   : TrackStatus
    Created on : May 26, 2020, 10:28:50 AM
    Author     : Jilasak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    if (session.getAttribute("namereq") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<style>

    .form-control {
        display: block;
        width: 100%;
        height: 25px;
        padding: 0rem 0.75rem;
        font-size: 0.9rem;
        font-weight: 400;
        line-height: 1.5;
        color: #495057;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid #ced4da;
        border-radius: 0.25rem;
        transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    }
    .col-md-2 {
        -ms-flex: 0 0 16.666667%;
        flex: 0 0 16.666667%;
        max-width: 16.666667%;
    }

    .form-control2 {
        display: block;
        width: 100%;
        height: 27px;
        /*padding: 0.375rem 0.75rem;*/
        font-size: 0.9rem;
        font-weight: 400;
        line-height: 1.5;
        color: #495057;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid #ced4da;
        border-radius: 0.25rem;
        transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    }

    .btn-lg {
        padding:  auto;
        font-size: 13px;
        font-weight: bold;
        line-height: normal;
        border-radius: 28px;
    }
    .jsgrid {
        position: relative;
        overflow: hidden;
        font-size: 13px;
    }

    .jsgrid-edit-row input, .jsgrid-edit-row select, .jsgrid-edit-row textarea, .jsgrid-filter-row input, .jsgrid-filter-row select, .jsgrid-filter-row textarea, .jsgrid-insert-row input, .jsgrid-insert-row select, .jsgrid-insert-row textarea {
        width: 100%;
        padding: .3em .5em;
        height: 20px;
    }


</style>


<body><br>
    <div class="container">
        <div id="jsGrid1" class="shadow"></div><br>
    </div>
</body>
<script>



    $("#jsGrid1").jsGrid({
        width: "100%",
        height: "auto",
        sorting: true,
        paging: true,
        autoload: true,
        filtering: true,
        pageSize: 10,
        pageButtonCount: 5,
        controller: {
            loadData: function (filter) {
                var USUREQ = "<%out.print(session.getAttribute("namereq"));%>";
                var data = $.Deferred();

                $.ajax({
                    type: 'GET',
                    url: './Sync',
                    dataType: 'json',
                    data: {
                        page: "authorizedisplay",
                        USUREQ: USUREQ
                    },
                    async: false
                }).done(function (response) {
                    response = $.grep(response, function (item) {
                        return (!filter.CTL_CODE || (item.CTL_CODE.indexOf(filter.CTL_CODE) > -1))
                                && (!filter.COMPANY.toUpperCase() || (item.COMPANY.indexOf(filter.COMPANY.toUpperCase()) > -1))
                                && (!filter.CTL_GRP.toUpperCase() || (item.CTL_GRP.indexOf(filter.CTL_GRP.toUpperCase()) > -1))
                                && (!filter.CTL_SEQ.toUpperCase() || (item.CTL_SEQ.indexOf(filter.CTL_SEQ.toUpperCase()) > -1))
                                && (!filter.CTL_STS.toUpperCase() || (item.CTL_STS.indexOf(filter.CTL_STS.toUpperCase()) > -1))
                                && (!filter.CTL_UID || (item.CTL_UID.indexOf(filter.CTL_UID) > -1))
                                && (!filter.CTL_REM || (item.CTL_REM.indexOf(filter.CTL_REM) > -1));

                    });
                    console.log(response);
                    data.resolve(response);
                });
                return data.promise();
            }
        },

        fields: [
            {title: "App Code", name: "CTL_CODE", type: "text", editing: false, align: "center", width: 50},
            {title: "Company", name: "COMPANY", type: "text", align: "center", width: 150, editing: true},
            {title: "GROUP", name: "CTL_GRP", type: "text", align: "center", width: 50},
            {title: "Sequence", name: "CTL_SEQ", type: "text", align: "center", width: 50},
//                {title: "E-Mail", name: "USMAIL", type: "text", align: "left", width: 200},
            {title: "Status", name: "CTL_STS", type: "text", align: "center", width: 50},
            {title: "ID(Username)", name: "CTL_UID", type: "text", align: "center", width: 50},
            {title: "ROLE", name: "CTL_REM", type: "text", align: "center", width: 50}
        ]
    });



</script>