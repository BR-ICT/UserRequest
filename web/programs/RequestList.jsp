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
<br>
<div class="container">
    <div id="jsGrid1" class="shadow"></div><br>
    <div class="card border-center-primary shadow h-100 py-2" id="detailform" hidden="true">
        <form name="Mail" id="Mail" method="GET" action="./sendmail">
            <div class="card-body">
                <div class="content">
                    <div class="row show-grid">
                        <div class="col-md-2">
                            <lable for="reqno">Request No.</lable>
                            <input  type="text" id="reqno" name="reqno" class="form-control text-center" readonly="true" style="font-weight: 500" value="">  
                        </div>
                        <div class="col-md-1">
                            <lable for="line">Line</lable>
                            <input type="text" id="line"  name="line" class="form-control text-center" readonly="true" value="" style="font-weight: 500">                     
                        </div>
                        <div class="offset-md-8 right" >                        
                            <a href="?page=RequestList">Back</a> 
                        </div>
                    </div>
                    <div class="row show-grid">
                        <div class="col-md-4">
                            <label for="disabledSelect" class="form-row" style="font-weight: bold;">Description :</label>
                        </div>
                    </div>
                    <div class="row show-grid">
                        <!--<div class="col-md-3" >-->
                        <div style="width:230px;height:50px;padding-left: 21px;">
                            <label for="EMPCODE" class="form-row">&nbsp;&nbsp;Staff code :&nbsp;
                                <input type="text" class="form-control" id="empcode" name="empcode"  maxlength="10" style="width: 120px; background-color: #03a9f412;"readonly="true">  
                            </label>
                        </div>                        
                        <div style="width:210px;height:50px;padding-left: 10px;">
                            <label for="name" class="form-row">Name :&nbsp;
                                <input type="text" class="form-control" id="name"  name="name" value="" style="width: 150px; background-color: #03a9f412;" readonly="true">
                            </label>
                        </div>
                        <div style="width:270px;height:50px;padding-left: 5px;">
                            <label for="surename" class="form-row">Last name :&nbsp;
                                <input type="text" class="form-control" id="lastname" name="lastname" value="" maxlength="30" style="width: 185px;background-color: #03a9f412;"readonly="true">
                            </label>
                        </div>
                        <div style="width:300px;height:50px;padding-left: 5px;">
                            <label for="email" class="form-row">&nbsp;Email :&nbsp;
                                <input  type="text" class="form-control" id="email"  name="email" maxlength="50" style="width: 250px;background-color: #03a9f412;" readonly="true">
                            </label>
                        </div>
                    </div>
                    <div class="row show-grid">
                        <div class="col-md-4">
                            <label for="disabledSelect" class="form-row" style="font-weight: bold;">Request for :</label>
                        </div>
                    </div>
                    <div class="row show-grid">
                        <!--                        <div class="col-md-4" >    
                                                    <label for="disabledSelect"class="form-row"style="padding-left: 15px">Company :&nbsp;
                                                        <select disabled="true" class="form-control select2-search--dropdown"  name="vCompany" id="vCompany" style="width: 200px">
                                                            <option value="" >Select company</option>
                                                        </select>
                                                    </label>
                                                </div>-->
                        <div class="col-md-4">
                            <label id="lblmail" class="form-row">To :&nbsp;
                                <input  type="text" class="form-control" id="MailCreator"  name="MailCreator" maxlength="30" style="width: 250px;background-color: #03a9f412;" readonly="true">
                            </label>
                        </div>
                        <div class="col-md-3">
                            <label id="lblSTN6L3" class="form-row">ST_N6L3 :&nbsp;
                                <input  type="text" class="form-control text-center" id="STN6L3"  name="STN6L3" maxlength="10" style="width: 150px;background-color: #FFFFFF;">                            
                            </label>
                        </div>
                        <div class="col-md-3">
                            <label id="lblcostcenter" class="form-row">Costcenter :&nbsp;
                                <input  type="text" class="form-control text-center" id="costcenter"  name="costcenter" style="width: 100px;background-color: #FFFFFF;"  readonly="true">                            
                            </label>
                        </div>
                    </div>



                    <div class="row show-grid" style="padding-top: 13px;">
                        <div class="col-md-4">
                            <label for="disabledSelect"style="font-weight: bold;">User group : &nbsp;</label>
                        </div>
                        <div class="col-md-4" id="fordisable">
                            <label for="disabledSelect"style="font-weight: bold;">User type : &nbsp;</label>
                        </div>
                    </div>
                    <div class="row show-grid">
                        <div class="col-md-4">
                            <label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="M3INFO" value="M3INFO" disabled="" onclick="selectgroup()"checked="">&nbsp;M3-Info </label>   <label style="color: #007bff;font-size: 12px; font-weight: bold;">(Request by user's head)</label>
                        </div>
                        <div class="col-md-2">
                            <label class="checkboxinline1"> <input  type="radio" name="checkboxinline" id="CheckboxNew" value="New" checked="" onclick="selecttype()">&nbsp;New &nbsp;</label> 
                        </div>
                        <div class="col-md-4" id="TYPEGROUP">
                            <label id="lbllike" class="form-row">Like user :&nbsp;&nbsp;
                                <input type="text" class="form-control" id="Like" value="" name="Like" maxlength="60" style="width: 230px;"></label>
                            <label id="lbltype" hidden="true" class="form-row">User type :&nbsp;
                                <select class="form-control select2-search--dropdown"  name="UserType" id="UserType" onchange="SelectEPR();"hidden="true" style="width: auto;">
                                    <option value="" selected="selected">Select Type</option>
                                    <option value="Requester">Requester</option>
                                    <option value="Approval">Approval</option>
                                </select>

                            </label>

                        </div>
                    </div>
                    <input type="text" class="form-control" id="creuser" name="creuser"  value="no" maxlength="60" style="width: 230px;" hidden="">   
                    <div class="row show-grid">
                        <div class="col-md-4">
                            <label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="AddOnM3" value="AddOnM3" onclick="selectgroup()" disabled="true">M3-Add on</label> <label style="color: #007bff;font-size: 12px; font-weight: bold;">(SRN,PRV,CAPEX,Incoming LD,..)</label>
                        </div>
                        <div class="col-md-2">
                            <label class="checkboxinline1"> <input  type="radio" name="checkboxinline" id="CheckboxAddF" value="AddFunc" onclick="selecttype()" >&nbsp;Add function &nbsp;</label> 
                        </div>
                        <div class="col-md-4" id="TYPEGROUP">
                            <label class="form-row">Function :&nbsp;&nbsp;
                                <input type="text" class="form-control" id="AddFun" name="AddFun" disabled="true" value="" maxlength="60" style="width: 230px;">
                            </label>
                        </div>
                    </div>
                    <div class="row show-grid">
                        <div class="col-md-4">
                            <label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="TARGIT" value="TARGIT" onclick="selectgroup()" disabled="true">&nbsp;TARGIT&nbsp;</label>&nbsp;&nbsp;
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="ESR" value="ESR" onclick="selectgroup()" disabled="true">&nbsp;ESR</label> <label style="color: #007bff;font-size: 12px; font-weight: bold;">(Stationery)</label>
                        </div>
                        <div class="col-md-2" id="fordisable">
                            <label class="checkboxinline1"> <input  type="radio" name="checkboxinline" id="CheckboxDelF" value="DelFunc" onclick="selecttype()" disabled="true"> Delete function</label>                    
                        </div>
                        <div class="col-md-4" id="TYPEGROUP">
                            <label class="form-row">Function :&nbsp;&nbsp;
                                <input type="text" class="form-control" id="DelFun" name="DelFun" disabled="true" value="" maxlength="60" style="width: 230px;">
                            </label>
                        </div>
                    </div>

                    <div class="row show-grid">
                        <div class="col-md-4">
                            <label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="CRM" value="CRM" onclick="selectgroup()" disabled="true">&nbsp;CRM&nbsp;</label>
                        </div>
                        <div class="col-md-2" id="fordisable">
                            <!--<label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>-->
                            <label class="radio-inline"> <input type="radio" name="checkboxinline" id="AppAuthorize" value="AppAuthorize" onclick="selecttype();Groupbyname();getAppname();" disabled="true">&nbsp;App Authorize&nbsp;</label>
                        </div>
                        <div class=" col-md-4" id="TYPEGROUP">
                            <label class="form-row">File :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <a id="OpenFile"><u> Open File </u></a>
                            </label>
                        </div>

                    </div>
                    <div class="row show-grid">
                        <div class="col-md-4">
                            <label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="Xiqma" value="Xiqma" disabled="true"  onclick="selectgroup()">&nbsp;Xiqma&nbsp;</label>                             
                        </div>
                    </div>
                    <div class="offset-md-4 col-md-2" id="TYPEGROUP">
                        <div class="" id="reportauthlbl">
                            <!--<label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>-->
                            <label class="radio-inline"> <input type="radio" name="checkboxinline" id="ReportAuthorize" value="ReportAuthorize" onclick="selecttype();Groupbyname();getAppname();" disabled="true">&nbsp;Report Authorize&nbsp;</label>
                        </div>
                    </div>
                    <br>
                    <label  id="headapp" for="lblapp" hidden="true"  style="font-weight: bold;">App Authorize</label>
                    <label for="isitgroupby"  id="headisitgroupby" hidden="true">
                        <input type="checkbox" id="isitgroupby" name="isitgroupby" checked="true" onchange="bygroupchange(this)" hidden="true">&nbsp; Add by group
                    </label>
                    <label for="isitbyapp"  id="headisitbyapp" hidden="">
                        <input type="checkbox" id="isitbyapp" name="isitbyapp" onchange="byappchange(this)" hidden="">&nbsp; Add by application
                    </label>
                    <br>
                    <label id="lblgroupapp" hidden="true">Group app :&nbsp; </label>
                    <select name="groupapp" id="groupapp" hidden="true" onchange="getrolelist('');" style="width: 140px;">
                        <!--<option value="" selected="selected">Select Type</option>-->
                    </select>
                    <label id="lblapp" hidden="true">App :&nbsp; </label>
                    <select name="Appname" id="Appname" hidden="true" onchange="getrolelist('');" style="width: 140px;">
                        <!--<option value="" selected="selected">Select Type</option>-->
                    </select>
                    <label id="lblrole" hidden="true" >Role :&nbsp; </label>
                    <select name="rolelist" id="rolelist" hidden="true" style="width: 140px;"onchange="" >
                        <option value="" selected="selected">Select Role</option>
                    </select>
                    <br>
                    <div class="row show-grid">
                        <div class="col-md-6">
                            <label class="form-row" style="padding-left: 15px;">Remark (ICT):
                                <input type="text" class="form-control2" id="Remark"  value="" maxlength="60" name="Remark" >
                            </label>
                        </div>

                        <div style="width:150px;height:25px;padding-left: 5px;">
                            <br>
                            <button type="button" id="Created" class="btn-danger btn-lg" >Approve</button>                         
                            <button type="submit" name="SendMail" id="SendMail" value="SendMailUser" hidden="true">Send E-mail</button>
                            <button type="reset"  id="reset" class="btn-success btn-lg" hidden="true">Reset</button>
                        </div>
                        <div class="offset-md-1 col-md-2">
                            <label class="form-row" style="padding-left: 15px;">Request by:
                                <input type="text" class="form-control2" id="req_by"    name="req_by"  readonly="true" style="background-color: #03a9f412;">
                            </label>
                        </div>


                    </div>
                </div>  
            </div>  
        </form>
        <input  hidden="true" id="CheckAuth" type="text" value="<%out.print(session.getAttribute("ST_COSTC"));%>">
        <div id="jsGrid3"></div>
    </div>    
    <br><br>

    <br>
</div>
<script>

    $(document).ready(function () {

    <% System.out.println("Path : " + request.getContextPath());%>
        var CheckAuth = document.getElementById("CheckAuth").value;
        if (CheckAuth !== "S8") {

            alert("You not authorization this page !!!");
            $(location).attr('href', './');
        }
//        $.ajax({
//            url: "./Sync",
//            type: "GET",
//            dataType: "json",
//            data: {
//                page: "Company"
//            },
//            success: function (getdata) {
//                $.each(getdata.data, function (i, obj) {
//                    var div_data = "<option value=" + obj.CCCONO + ">" + obj.CCCONO + " : " + obj.CCTX15 + "</option>";
//                    //console.log(div_data)
//                    $(div_data).appendTo('#vCompany');
//                });
//            }
//        });
    });
    $("#jsGrid1").jsGrid({
        width: "100%",
        height: "auto",
        sorting: true,
        paging: true,
        autoload: true,
        filtering: true,
        pageSize: 12,
        pageButtonCount: 5,
        controller: {
            loadData: function (filter) {
                var data = $.Deferred();
                $.ajax({
                    type: 'GET',
                    url: './Sync',
                    dataType: 'json',
                    data: {
                        page: "Request_List"
                    },
                    async: false
                }).done(function (response) {
                    response = $.grep(response, function (item) {
                        return (!filter.USREQNO || (item.USREQNO.indexOf(filter.USREQNO) > -1))
                                && (!filter.USLINE.toUpperCase() || (item.USLINE.indexOf(filter.USLINE.toUpperCase()) > -1))
//                                && (!filter.USCOMP.toUpperCase() || (item.USCOMP.indexOf(filter.USCOMP.toUpperCase()) > -1))
                                && (!filter.USNAME1.toUpperCase() || (item.USNAME1.indexOf(filter.USNAME1.toUpperCase()) > -1))
                                && (!filter.USNAME2.toUpperCase() || (item.USNAME2.indexOf(filter.USNAME2.toUpperCase()) > -1))
//                                && (!filter.USCOSTC.toUpperCase() || (item.USCOSTC.indexOf(filter.USCOSTC.toUpperCase()) > -1))
                                && (!filter.USGROUP || (item.USGROUP.indexOf(filter.USGROUP) > -1))
                                && (!filter.USTYPE || (item.USTYPE.indexOf(filter.USTYPE) > -1))
                                && (!filter.DATE.toUpperCase() || (item.DATE.indexOf(filter.DATE.toUpperCase()) > -1));
                    });
                    console.log(response);
                    data.resolve(response);
                });
                return data.promise();
            }
        },
        fields: [

            {title: "REQNO", name: "USREQNO", type: "text", editing: false, align: "center", width: 75},
            {title: "Line", name: "USLINE", type: "text", align: "center", width: 50},
//            {title: "Company", name: "USCOMP", type: "text", align: "center", width: 80, editing: true},
            {title: "Name", name: "USNAME1", type: "text", align: "left"},
            {title: "Last Name", name: "USNAME2", type: "text", align: "left", width: 150},
            {title: "E-Mail", name: "USMAIL", type: "text", align: "left", width: 250},
//            {title: "CostC.", name: "USCOSTC", type: "text", align: "center", width: 90},
            {title: "Group", name: "USGROUP", type: "text", align: "center"},
            {title: "Type", name: "USTYPE", type: "text", align: "center", width: 90},
            {title: "Date", name: "DATE", type: "text", align: "center"}
        ],
        rowClick: function (args) {
//            console.log(args.item);
            showDetailsDialog1("GET", args.item);
        }

    });

    var showDetailsDialog1 = function (dialogType, client) {
        document.getElementById("detailform").hidden = false;

        $("#jsGrid1").hide();
        var input = "" + client.USTYPE;
        console.log("test");
        var fields = input.split(',');

        var Like = client.USLIKE;
//         console.log(Like);
        var AddFunc = client.USAFUNC;
//         console.log(AddFunc);
        var DelFunc = client.USDFUNC;
//         console.log(DelFunc);
        var App = client.USAPP;
        var Groupapp = client.USGROUPAPP;
        var Role = client.USROLE;
//COSTCENTER
        document.getElementById("Like").value = Like;
        document.getElementById("AddFun").value = AddFunc;
        document.getElementById("DelFun").value = DelFunc;
        document.getElementById("req_by").value = client.USUREQ;
        $("#reqno").val(client.USREQNO);
        $("#line").val(client.USLINE);
        $("#Remark").val(client.USERNAME);
        $("#empcode").val(client.USCODE);
        $("#costcenter").val(client.COSTCENTER);
        document.getElementById("name").value = client.USNAME1;
        document.getElementById("lastname").value = client.USNAME2;
        document.getElementById("email").value = client.USMAIL;
        document.getElementById("MailCreator").value = client.USEMCRE;
        $("#UserType").val(client.USLIKE);
        $("#Add").hide();
        $("#TYPEGROUP :input").prop("disabled", true);
        $("#fordisable :input").prop("disabled", true);
//        $("#vCompany").val(client.USCOMP);
        $("#STN6L3").val(client.USERNAME);
        $('input[name="checkboxinline"]').each(function () {
            this.checked = false;
        });
        if (client.USGROUP === "Xiqma") {
            document.getElementById("Xiqma").checked = true;
            document.getElementById("creuser").value = "0";
        } else if (client.USGROUP === "AddOnM3") {
            document.getElementById("AddOnM3").checked = true;
            document.getElementById("creuser").value = "addon";
            var currentYear = new Date().getFullYear();
            var username = client.USERNAME;
            var Remark = "Username:" + username + " Password:brl@" + currentYear;
            $("#Remark").val(Remark);
        } else if (client.USGROUP === "EPR") {
            document.getElementById("EPR").checked = true;
            document.getElementById("lbllike").hidden = true;
            document.getElementById("lbltype").hidden = false;
            document.getElementById("creuser").value = "0";
        } else if (client.USGROUP === "CRM") {
            document.getElementById("CRM").checked = true;
            document.getElementById("creuser").value = "0";
        } else if (client.USGROUP === "M3INFO") {
            document.getElementById("M3INFO").checked = true;
            document.getElementById("creuser").value = "0";
        } else if (client.USGROUP === "ESR") {
            document.getElementById("ESR").checked = true;
            document.getElementById("creuser").value = "0";
        } else {
            document.getElementById("creuser").value = "0";
        }
        selectgroup();
        for (var i = 0; i < 3; i++) {
            var type = fields[i];
            console.log(type);

            if (type === "New" && client.USGROUP !== "M3INFO" && (client.USGROUP !== "ESR" && client.USGROUP !== "EPR")) {
                document.getElementById("lbltype").hidden = true;
                document.getElementById("UserType").hidden = true;
                document.getElementById("Like").hidden = false;
                document.getElementById("lbllike").hidden = false;

                document.getElementById("CheckboxNew").checked = true;
                document.getElementById("Like").disabled = true;
                document.getElementById("CheckboxNew").disabled = true;
                document.getElementById("CheckboxAddF").disabled = true;
                document.getElementById("CheckboxDelF").disabled = true;
                if (type === "AddOnM3") {
                    document.getElementById("AppAuthorize").disabled = true;
                    document.getElementById("ReportAuthorize").disabled = true;
                }

            } else if (type === "New" && client.USGROUP === "M3INFO") {
                document.getElementById("lbltype").hidden = true;
                document.getElementById("UserType").hidden = true;
                document.getElementById("Like").hidden = false;
                document.getElementById("lbllike").hidden = false;

                document.getElementById("CheckboxNew").checked = true;
                document.getElementById("Like").disabled = true;
                document.getElementById("CheckboxNew").disabled = true;

            } else if (type === "AddFunc" && client.USGROUP === "M3INFO") {
                document.getElementById("lbltype").hidden = true;
                document.getElementById("UserType").hidden = true;
                document.getElementById("Like").hidden = false;
                document.getElementById("lbllike").hidden = false;

                document.getElementById("CheckboxAddF").checked = true;
                document.getElementById("AddFun").disabled = true;
                document.getElementById("CheckboxAddF").disabled = true;

            } else if (type === "DelFunc" && client.USGROUP === "M3INFO") {
                document.getElementById("lbltype").hidden = true;
                document.getElementById("UserType").hidden = true;
                document.getElementById("Like").hidden = false;
                document.getElementById("lbllike").hidden = false;

                document.getElementById("CheckboxDelF").checked = true;
                document.getElementById("DelFun").disabled = true;
                document.getElementById("CheckboxDelF").disabled = true;
                document.getElementById("File").disabled = true;
                document.getElementById("File").hidden = true;

            } else if (type === "New" && (client.USGROUP === "ESR" || client.USGROUP === "EPR")) {
                document.getElementById("CheckboxNew").checked = true;
                document.getElementById("CheckboxAddF").disabled = true;
                document.getElementById("CheckboxDelF").disabled = true;
                document.getElementById("lbltype").hidden = false;
                document.getElementById("UserType").hidden = false;
                document.getElementById("UserType").disabled = true;
                document.getElementById("UserType").value = Like;
                document.getElementById("Like").hidden = true;
                document.getElementById("lbllike").hidden = true;
                document.getElementById("Like").disabled = true;
                document.getElementById("Like").value = Like;
            } else if (type === "AppAuthorize")
            {

                document.getElementById("AppAuthorize").checked = true;
//                selecttype();

//                if (App === "") {
////                    console.log("grouptest");
//                    $("#isitgroupby").prop("checked", true);
//                    $("#isitbyapp").prop("checked", false);
//                } else if (Groupapp === "") {
////                    console.log("apptest");
//                    $("#isitbyapp").prop("checked", true);
//                    $("#isitgroupby").prop("checked", false);
//                }
//                $("#AppAuthorize").trigger('onclick');
////                $("#Appname").val(App);
////                console.log(App);
//                document.getElementById("Appname").value = App;
//                document.getElementById("groupapp").value = Groupapp;
//                getrolelist(Role);
////                document.getElementById("").value = Role;
//                $("#rolelist").val(Role);

//                console.log(Role);
            } else if (type === "ReportAuthorize")
            {
                document.getElementById("ReportAuthorize").checked = true;
//                selecttype();
//                if (App === "") {
//                    $("#isitgroupby").prop("checked", true);
//                    $("#isitbyapp").prop("checked", false);
//                } else if (Groupapp === "") {
//                    $("#isitbyapp").prop("checked", true);
//                    $("#isitgroupby").prop("checked", false);
//                }
//                $("#ReportAuthorize").trigger('onclick');
//                document.getElementById("Appname").value = App;
//
//                document.getElementById("groupapp").value = Groupapp;
//                getrolelist(Role);
//                $("#rolelist").val(Role);
//                console.log(Role);
            }
            if (client.USGROUP === "AddOnM3") {
                document.getElementById("AppAuthorize").disabled = true;
                document.getElementById("ReportAuthorize").disabled = true;
            }

        }


        console.log($("#reqno").val());
        console.log(client.USUREQ);

        $("#jsGrid3").jsGrid({
            width: "100%",
            height: "auto",
            sorting: true,
            paging: true,
            autoload: true,
            pageSize: 10,
            pageButtonCount: 5,
            deleteConfirm: function (item) {
                return "Requser No. " + item.USREQNO + " Line : " + item.USLINE + " will be removed. Are you sure?";
            },
            controller: {
                loadData: function (filter) {
                    var data = $.Deferred();
                    var cono = <%out.print(session.getAttribute("cono"));%>
                    var divi = <%out.print(session.getAttribute("divi"));%>
                    var reqno = document.getElementById("reqno").value;
                    $.ajax({
                        type: 'GET',
                        url: './Sync',
                        dataType: 'json',
                        data: {
                            page: "Table_USRREQ",
                            USREQNO: $("#reqno").val()
                        },
                        async: false
                    }).done(function (response) {
                        console.log(response);
                        data.resolve(response);
                    });
                    return data.promise();
                },
                deleteItem: function (item) {
                    console.log(item);
                    item.page = "DeleteLine";
                    $.ajax({
                        type: "POST",
                        url: "./Sync",
                        async: false,
                        cache: false,
                        data: item
                    });
                    $("#jsGrid3").jsGrid("loadData");
                    $("#reset").click();
                    GetMaxLine();
                    $("#Add").show();
                    $("#Send").show();
                    $("#Save").hide();
                    selectgroup();
                    document.getElementById("AddFun").disabled = true;
                    document.getElementById("DelFun").disabled = true;
//                    document.getElementById("MailCreator").value = "";
                }
            },
            fields: [
                {type: "control", editButton: false, deleteButton: false, width: 50},
                {title: "REQNO", name: "USREQNO", type: "text", editing: false, align: "center", width: 75},
                {title: "Line", name: "USLINE", type: "text", align: "center", width: 50},
                {title: "Company", name: "USCOMP", type: "text", align: "center", width: 80, editing: true},
                {title: "Code", name: "USCODE", type: "text", editing: false, align: "center", width: 75},
                {title: "Name", name: "USNAME1", type: "text", align: "left"},
                {title: "Last Name", name: "USNAME2", type: "text", align: "left", width: 150},
                {title: "E-Mail", name: "USMAIL", type: "text", align: "left", width: 250},
//                    {title: "Costc.", name: "USCOSTC", type: "text", align: "center"},
                {title: "Group", name: "USGROUP", type: "text", align: "center"},
                {title: "Type", name: "USTYPE", type: "text", align: "center"},
                {title: "Like User", name: "USLIKE", type: "text", align: "left", width: 200},
                {title: "Add Function", name: "USAFUNC", type: "text", align: "left", width: 200},
                {title: "Delete Function", name: "USDFUNC", type: "text", align: "left", width: 200},
                {title: "Date", name: "USREQDT", type: "text", align: "center"},
                {title: "Creator", name: "USEMCRE", type: "text", align: "left", width: 250},
                {title: "Group app", name: "USGROUPAPP", type: "text", align: "left", width: 100},
                {title: "App", name: "USAPP", type: "text", align: "left", width: 100},
                {title: "Role", name: "USROLE", type: "text", align: "left", width: 100}
            ],
            rowClick: function (args) {
//            console.log(args.item);
//                showDetailsDialog2("GET", args.item);
//                console.log("test");
            }
        });
    };













    function selecttype() {
        // Get the checkbox
        var CheckboxNew = document.getElementById("CheckboxNew");
        var CheckboxAddF = document.getElementById("CheckboxAddF");
        var CheckboxDelF = document.getElementById("CheckboxDelF");
        var CheckboxAuth = document.getElementById("AppAuthorize");
        var CheckboxReport = document.getElementById("ReportAuthorize");
        // If the checkbox is checked, display the output text
        if (CheckboxNew.checked === true) {
            document.getElementById("Like").disabled = true;
            document.getElementById("UserType").disabled = true;
        } else {
//            document.getElementById("Like").value = "";
            document.getElementById("Like").disabled = true;
            document.getElementById("UserType").disabled = true;

        }

        if (CheckboxAddF.checked === true) {
            document.getElementById("AddFun").disabled = true;
        } else {
//            document.getElementById("AddFun").value = "";
            document.getElementById("AddFun").disabled = true;


        }

        if (CheckboxDelF.checked === true) {
            document.getElementById("DelFun").disabled = true;

        } else {
//            document.getElementById("DelFun").value = "";
            document.getElementById("DelFun").disabled = true;
        }

        if (CheckboxAuth.checked === true) {
//            document.getElementById("headapp").hidden = false;
//            document.getElementById("lblapp").hidden = false;
//            document.getElementById("Appname").hidden = false;
//            document.getElementById("Conoinp").hidden = false;
//            document.getElementById("lblcono").hidden = false;
//            document.getElementById("lblgroupapp").hidden = false;
//            document.getElementById("groupapp").hidden = false;
//            document.getElementById("isitgroupby").hidden = false;
//            document.getElementById("headisitgroupby").hidden = false;
//            document.getElementById("isitbyapp").hidden = false;
//            document.getElementById("headisitbyapp").hidden = false;
//            document.getElementById("lblrole").hidden = false;
//            document.getElementById("rolelist").hidden = false;
//            document.getElementById("headapp").innerText = "App Authorize";

            var checkboxElement = document.getElementById("isitgroupby");
            var checkboxElement2 = document.getElementById("isitbyapp");
            bygroupchange(checkboxElement);
            byappchange(checkboxElement2);
        } else if (CheckboxReport.checked === true) {
//            document.getElementById("headapp").hidden = false;
//            document.getElementById("lblapp").hidden = false;
//            document.getElementById("Appname").hidden = false;
////            document.getElementById("Conoinp").hidden = false;
////            document.getElementById("lblcono").hidden = false;
//            document.getElementById("lblgroupapp").hidden = false;
//            document.getElementById("groupapp").hidden = false;
//            document.getElementById("isitgroupby").hidden = false;
//            document.getElementById("headisitgroupby").hidden = false;
//            document.getElementById("isitbyapp").hidden = false;
//            document.getElementById("headisitbyapp").hidden = false;
//            document.getElementById("lblrole").hidden = true;
//            document.getElementById("rolelist").hidden = true;
//            document.getElementById("headapp").innerText = "Report Authorize";
//
//            var checkboxElement = document.getElementById("isitgroupby");
//            var checkboxElement2 = document.getElementById("isitbyapp");
//            bygroupchange(checkboxElement);
//            byappchange(checkboxElement2);
//            console.log("Case2");
        } else {
            document.getElementById("headapp").hidden = true;
            document.getElementById("lblapp").hidden = true;
            document.getElementById("Appname").hidden = true;
//            document.getElementById("Conoinp").hidden = true;
//            document.getElementById("lblcono").hidden = true;
            document.getElementById("lblgroupapp").hidden = true;
            document.getElementById("groupapp").hidden = true;
            document.getElementById("isitgroupby").hidden = true;
            document.getElementById("headisitgroupby").hidden = true;
            document.getElementById("isitbyapp").hidden = true;
            document.getElementById("headisitbyapp").hidden = true;
            document.getElementById("lblrole").hidden = true;
            document.getElementById("rolelist").hidden = true;
//            console.log("Case3");
        }


    }


    function selectgroup() {

        var radioValue = $("input[name='optionsRadio']:checked").val();
        if (radioValue === "AddOnM3") {
            document.getElementById("CheckboxNew").checked = true;
            document.getElementById("CheckboxAddF").checked = false;
            document.getElementById("CheckboxDelF").checked = false;
            selecttype();
            document.getElementById("CheckboxAddF").disabled = true;
            document.getElementById("CheckboxDelF").disabled = true;
            document.getElementById("AppAuthorize").disabled = true;
            document.getElementById("ReportAuthorize").disabled = true;
            SelectEPR();
        } else if (radioValue !== "M3INFO" && radioValue !== "EPR" && radioValue !== "ESR") {

            document.getElementById("CheckboxNew").checked = true;
            document.getElementById("CheckboxAddF").checked = false;
            document.getElementById("CheckboxDelF").checked = false;
            selecttype();
            document.getElementById("CheckboxAddF").disabled = true;
            document.getElementById("CheckboxDelF").disabled = true;
            document.getElementById("AppAuthorize").disabled = true;
            document.getElementById("ReportAuthorize").disabled = true;
            SelectEPR();
        } else if (radioValue === "EPR" || radioValue === "ESR") {
            document.getElementById("CheckboxNew").checked = true;
            document.getElementById("CheckboxAddF").checked = false;
            document.getElementById("CheckboxDelF").checked = false;
            selecttype();
            document.getElementById("CheckboxAddF").disabled = true;
            document.getElementById("CheckboxDelF").disabled = true;
            SelectEPR();
            document.getElementById("AppAuthorize").disabled = true;
            document.getElementById("ReportAuthorize").disabled = true;
        } else {
            document.getElementById("CheckboxNew").disabled = true;
            document.getElementById("CheckboxAddF").disabled = true;
            document.getElementById("CheckboxDelF").disabled = true;
            document.getElementById("AppAuthorize").disabled = true;
            document.getElementById("AppAuthorize").checked = true;
            document.getElementById("CheckboxNew").checked = true;
            document.getElementById("ReportAuthorize").disabled = true;
            document.getElementById("ReportAuthorize").checked = false;

            selecttype();
            SelectEPR();
        }
    }

    function SelectEPR() {

        var radioValue = $("input[name='optionsRadio']:checked").val();
        if (radioValue === "EPR" || radioValue === "ESR" || radioValue === "TARGIT") {
            document.getElementById("lbltype").hidden = false;
            document.getElementById("UserType").hidden = false;
            document.getElementById("Like").hidden = true;
            document.getElementById("lbllike").hidden = true;
            document.getElementById("Like").disabled = true;
            document.getElementById("Like").value = $("#UserType").val();
        } else if (radioValue === "M3INFO") {

            if (document.getElementById("Like").value === "Requester" || document.getElementById("Like").value === "Approval") {
//                document.getElementById("Like").value = "";
            }

            document.getElementById("lbltype").hidden = true;
            document.getElementById("UserType").hidden = true;
            document.getElementById("Like").hidden = false;
            document.getElementById("lbllike").hidden = false;
            document.getElementById("Like").disabled = true;
        } else if (radioValue === "AppAuthorize") {

            document.getElementById("lblapp").hidden = false;
            document.getElementById("Appname").hidden = false;
            document.getElementById("lbltype").hidden = true;
            document.getElementById("UserType").hidden = true;
            document.getElementById("Like").hidden = true;
            document.getElementById("lbllike").hidden = true;
            document.getElementById("Like").disabled = true;


        } else {
            document.getElementById("lbltype").hidden = true;
            document.getElementById("UserType").hidden = true;
            document.getElementById("Like").hidden = false;
            document.getElementById("lbllike").hidden = false;
            document.getElementById("Like").value = "";
            document.getElementById("Like").disabled = true;
        }
    }
    function getAppname() {
        var authurize = document.getElementById("AppAuthorize").checked;
        var reportauth = document.getElementById("ReportAuthorize").checked;
        var authorreport = "";
        if (authurize) {
            authorreport = "APP";
        } else if (reportauth) {
            authorreport = "REP";
        }
        $.ajax({
            url: './Sync',
            type: 'GET',
            dataType: 'json',
            data: {
                page: "getAppname",
                authorreport: authorreport
            },
            async: false
        }).done(function (response) {
            console.log(response);
            $('#Appname').empty().append('<option value="" selected="selected">Select app</option>');
            $.each(response, function (i, obj) {
                var div_data = "<option value=" + obj.Appname + ">" + obj.Appname + "</option>";
                $(div_data).appendTo('#Appname');
//                console.log("Appname run");
            });
        });

    }
    ;
    getAppname();


    function Groupbyname() {
        var authurize = document.getElementById("AppAuthorize").checked;
        var reportauth = document.getElementById("ReportAuthorize").checked;
        var authorreport = "";
        if (authurize) {
            authorreport = "APP";
        } else if (reportauth) {
            authorreport = "REP";
        }
//        console.log(authorreport);

        $.ajax({
            url: './Sync',
            type: 'GET',
            dataType: 'json',
            data: {
                page: "getGroupapp",
                authorreport: authorreport
            },
            async: false
        }).done(function (response) {
            console.log(response);
            $('#groupapp').empty().append('<option value="" selected="selected">Select Group</option>');
            $.each(response, function (i, obj) {
                var div_data = "<option value=" + obj.CTL2_GRP + ">" + obj.CTL2_NAME + "</option>";
                $(div_data).appendTo('#groupapp');
//                console.log("Appname run");
            });
        });
    }
    ;
    Groupbyname();


    function bygroupchange(checkbox) {
        console.log("by group change")
        var groupby = document.getElementById("isitgroupby");
        var appby = document.getElementById("isitbyapp");
        if (checkbox.checked) {
            if (groupby.checked === true && appby.checked === true) {
                appby.disabled = true;
                appby.checked = false;
            }
            groupby.disabled = true;
            document.getElementById("lblgroupapp").hidden = false;
            document.getElementById("groupapp").hidden = false;
            document.getElementById("lblapp").hidden = true;
            document.getElementById("Appname").hidden = true;
        } else {
            if (appby.checked) {
                appby.disabled = true;
                appby.checked = true;
            }
            groupby.disabled = true;
            document.getElementById("lblgroupapp").hidden = true;
            document.getElementById("groupapp").hidden = true;
//            document.getElementById("lblapp").hidden = false;
//            document.getElementById("Appname").hidden = false;
        }
        clearappgrouprole();
    }

    function byappchange(checkbox) {
        var groupby = document.getElementById("isitgroupby");
        var appby = document.getElementById("isitbyapp");
//        console.log(appby);
//        console.log(groupby);
        if (checkbox.checked) {
            if (groupby.checked === true && appby.checked === true) {
                groupby.disabled = true;
                groupby.checked = false;
            }
            appby.disabled = true;
            document.getElementById("lblapp").hidden = false;
            document.getElementById("Appname").hidden = false;
            document.getElementById("lblgroupapp").hidden = true;
            document.getElementById("groupapp").hidden = true;

        } else {
            if (groupby.checked) {
                groupby.disabled = true;
                groupby.checked = true;
            }
            appby.disabled = true;
            document.getElementById("lblapp").hidden = true;
            document.getElementById("Appname").hidden = true;
//            document.getElementById("lblgroupapp").hidden = false;
//            document.getElementById("groupapp").hidden = false;

        }
//        console.log("add");
        clearappgrouprole();
    }


    function getrolelist(role) {
        console.log("test5");
        var groupby = document.getElementById("isitgroupby").checked;
        var appby = document.getElementById("isitbyapp").checked;
        $.ajax({
            url: "./Sync",
            type: "GET",
            dataType: "json",
            data: {
                page: "getRole",
                isitGroupby: groupby,
                isitAppby: appby,
                Groupby: $("#groupapp").val(),
                Appby: $("#Appname").val()
            },
            success: function (getdata) {
                $('#rolelist').empty().append('<option value="" selected="selected">Select Role</option>');
                $.each(getdata, function (i, obj) {
//                    console.log("getdata");

                    var div_data = "<option value=" + obj.CTL2_REM1 + ">" + obj.CTL2_REM1 + "</option>";
                    //console.log(div_data)
                    $(div_data).appendTo('#rolelist');
                });
                $("#rolelist").val(role);
            }
        });
    }

    function clearappgrouprole() {
        $('#Appname').val("");
        $('#groupapp').val("");
        $('#rolelist').empty().append('<option value="" selected="selected">Select role</option>');
//    $('#groupapp').val("");
    }

    $("#OpenFile").click(function (e) {

        var File;
        var TYPE;
        $.ajax({
            url: './Sync',
            type: 'GET',
            dataType: 'json',
            data: {
                page: "ShowFile",
                USREQNO: $("#reqno").val(),
                USLINE: $("#line").val()
            },
            async: false
        }).done(function (response) {
            $.each(response, function (i, obj) {
                File = obj.USFILE;
                TYPE = obj.TYPE;

            });
        });

        TYPE = TYPE.split('.');
        let pdfWindow = window.open("");
        if (TYPE[1] === "pdf" || TYPE[1] === "PDF") {
            setTimeout(() => {
                pdfWindow.document.write("<html<head><title>" + "PDF" + "</title><style>body{margin: 11px;}iframe{border-width: 10px;}</style></head>");
                pdfWindow.document.write("<body><embed width='100%' height='100%' src='data:application/pdf;base64, " + encodeURI(File) + "#toolbar=0&navpanes=0&scrollbar=0'></embed>\n\ </body></html>");
            }, 500);
        } else {
            setTimeout(() => {
                pdfWindow.document.write("<html<head><title>" + "PDF" + "</title><style>body{margin: 11px;}iframe{border-width: 10px;}</style></head>");
                pdfWindow.document.write("<body><img src='data:image/png;base64," + encodeURI(File) + "'  width='50%' height='50%'>\n\ </body></html>");
            }, 500);
        }
        ;

    });

    $("#Created").click(function (e) {

        var username = document.getElementById('STN6L3').value;
        var checkExistUser = 1;
        $.ajax({
            url: './Sync',
            type: 'GET',
            dataType: 'text',
            data: {
                page: "checkExistUser",
                username: username


            },
            async: false
        }).done(function (response) {

            checkExistUser = response;

        });

        if (0 == 0) {

            var radioValue = $("input[name='optionsRadio']:checked").val();

            console.log(radioValue);

//            alert("CREATE USER AS400");
            if (radioValue === "AddOnM3") {
                console.log("xxxxxxxxxxx");
//                document.getElementById("creuser").value = "addon";
//                $("#creuser").val("addon");
                var USREQ = "<%out.print(session.getAttribute("namereq"));%>";
                $.ajax({
                    url: './Sync',
                    type: 'POST',
                    data: {
                        page: "UpdateCreated",
                        USREQNO: $("#reqno").val(),
                        USLINE: $("#line").val(),
                        USREMK: $("#Remark").val(),
                        USCREBY: USREQ
                    },
                    async: false
                }).done(function (response) {

                    console.log("update completed.");

                });

//                $("#SendMail").click();

            }
            $("#SendMail").click();
            alert("Send e-mail complete");

        } else {
            alert("This username already exist. Please try another username or reset password.  ");
        }

//        $("#SendMail").click();
//        alert("Send e-mail complete");
//        location.reload(0);






    });
    function  back() {
        location.reload(0);
    }
//$("#creuser").hide();

</script>


