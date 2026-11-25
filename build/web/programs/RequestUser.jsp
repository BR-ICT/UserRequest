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
    .error {
        color: red;

    }
    .btn-block2 {
        display: block;
        width: 100%;
        height: 25px;
    }
    .select2-selection{
        text-align: center;
    }
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #444;
        line-height: 24px;
    }

</style>
<br>
<div class="container">
    <div class="card border-center-primary shadow h-100 py-2">
        <div class="card-body">
            <div class="content">
                <div class="row col-md-12 text-center">
                    <h3 class="text-center col-md-12 col-sm-12 col-lg-12" style="color: blue">
                        <u>User Request</u>
                    </h3>
                </div>
                <div class="row show-grid col-md-12">
                    <div class="offset-sm-9">
                    </div>  
                    <div class="col-sm-2">
                        <lable for="reqno">Request No.</lable>
                        <input  type="text" id="reqno"  name="reqno" class="form-control text-center" disabled="true" style="font-weight: 500" value="">  
                    </div>
                    <div class="col-sm-1">
                        <lable for="line">Line</lable>
                        <input type="text" id="line"  class="form-control text-center" disabled="true" value="1" style="font-weight: 500;width: 100%">                     
                    </div>
                </div>
                <div class="row show-grid">
                    <div class="col-md-4">
                        <label for="disabledSelect" class="form-row" style="font-weight: bold;">Description :</label>
                    </div>
                </div>
                <div class="row show-grid">
                    <div style="width:230px;height:50px;padding-left: 10px;">
                        <label for="EMPCODE"class="form-row"style="width:230px;height:50px;padding-left: 15px;">Staff code :&nbsp;
                            <select class="select2-container--default"  name="empcode" id="empcode"  style="width: 126px; text-align: center" onchange="GetDetail()">
                                <option  value="" selected="selected"></option>
                            </select>
                        </label>
                    </div>                        
                    <div style="width:210px;height:50px;padding-left: 12px;">
                        <label for="name" class="form-row">Name :&nbsp;
                            <input type="text" class="form-control" id="name" onkeyup='check_EN(this)' name="name" value="" style="width: 150px; background-color: #03a9f412;" readonly="true">
                        </label>
                    </div>
                    <div style="width:270px;height:50px;padding-left: 5px;">
                        <label for="surename" class="form-row">&nbsp;Last name :&nbsp;
                            <input type="text" class="form-control" id="lastname" onkeyup='check_EN(this)'name="lastname" value="" maxlength="30" style="width: 185px;background-color: #03a9f412;"readonly="true">
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
                    <div class="col-md-4" >    
                        <label for="disabledSelect"class="form-row"style="padding-left: 15px">Company :&nbsp;
                            <select class="form-control select2-search--dropdown"  name="vCompany" id="vCompany" style="width: 200px">
                                <option value="" >Select company</option>
                            </select>
                        </label>
                    </div>
                    <div class="col-md-4">
                        <label id="lblmail" class="form-row">To :&nbsp;
                            <select class="form-control select2-search--dropdown"  name="MailCreator" id="MailCreator" style="width: 250px">
                                <option value="" selected="selected">Select Creator</option>
                            </select>
                        </label>
                    </div>
                </div>
                <br>
                <form id="Myform" method="POST" action="./UploadFile" enctype="multipart/form-data" acceptcharset="UTF-8">
                    <div class="row show-grid">
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
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="M3INFO" value="M3INFO" onclick="selectgroup()"checked="">&nbsp;M3-Info </label>   <label style="color: #007bff;font-size: 12px; font-weight: bold;">(Request by user's head)</label>
                        </div>
                        <div class="col-md-2">
                            <label class="checkboxinline1"> <input  type="radio" name="checkboxinline" id="CheckboxNew" value="New" checked="" onclick="selecttype(false)">&nbsp;New &nbsp;</label> 
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
                    <div class="row show-grid">
                        <div class="col-md-4">
                            <label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="AddOnM3" value="AddOnM3" onclick="selectgroup()"> M3-Add on</label> <label style="color: #007bff;font-size: 12px; font-weight: bold;">(SRN,PRV,CAPEX,Incoming LD,..)</label>
                        </div>
                        <div class="col-md-2">
                            <label class="checkboxinline1"> <input  type="radio" name="checkboxinline" id="CheckboxAddF" value="AddFunc" onclick="selecttype(false)" >&nbsp;Add function &nbsp;</label> 
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
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="TARGIT" value="TARGIT" onclick="selectgroup()">&nbsp;TARGIT&nbsp;</label>&nbsp;&nbsp;
                            <!--<label class="radio-inline"> <input type="radio" name="optionsRadio" id="ESR" value="ESR" onclick="selectgroup()">&nbsp;ESR</label> <label style="color: #007bff;font-size: 12px; font-weight: bold;">(Stationery)</label>-->
                        </div>
                        <div class="col-md-2" id="fordisable">
                            <label class="checkboxinline1"> <input  type="radio" name="checkboxinline" id="CheckboxDelF" value="DelFunc" onclick="selecttype(false)" > Delete function</label>                    
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
                            <label class="radio-inline"> <input type="radio" name="optionsRadio" id="CRM" value="CRM" onclick="selectgroup()">&nbsp;CRM&nbsp;</label>
                        </div>
                        <div class="col-md-2" id="fordisable">
                            <!--<label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>-->
                            <label class="radio-inline"> <input type="radio" name="checkboxinline" id="AppAuthorize" value="AppAuthorize" onclick="selecttype(false);Groupbyname();getAppname();" disabled="">&nbsp;App Authorize&nbsp;</label>
                        </div>
                        <div class="" id="TYPEGROUP">
                            <label class="form-row">&nbsp;&nbsp;&nbsp;File :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="file"id="File" name="File"  style="width: 100px;" >
                            </label>
                        </div>
                    </div>
                    <div class="row show-grid">
                        <div class="col-md-4" >
                            <label for="disabledSelect" style="color:white" hidden="true">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <label class="radio-inline"hidden="true"> <input type="radio" name="optionsRadio" id="Xiqma" value="Xiqma"   onclick="selectgroup()">&nbsp;Xiqma&nbsp;</label> <label style="color: #007bff;font-size: 12px; font-weight: bold;"hidden="true"> (Leave request, Material request,New Supplier, New Customer,....)</label>                            
                        </div>
                        <div class="col-md-2" id="reportauthlbl">
                            <!--<label for="disabledSelect" style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>-->
                            <label class="radio-inline"> <input type="radio" name="checkboxinline" id="ReportAuthorize" value="ReportAuthorize" onclick="selecttype(false);Groupbyname();getAppname();" disabled="">&nbsp;Report Authorize&nbsp;</label>
                        </div>
                        <div class="col-md-2" id="TYPEGROUP">
                            <label class="form-row" style="color: red">PDF,PNG,JPG เท่านั้น </label>
                        </div>
                    </div>
                    <label  id="headapp" for="lblapp" hidden="true"  style="font-weight: bold;">App Authorize</label>
                    <label for="isitgroupby"  id="headisitgroupby" >
                        <input type="checkbox" id="isitgroupby" name="isitgroupby" checked="true" onchange="bygroupchange(this)">&nbsp; Add by group
                    </label>
                    <label for="isitbyapp"  id="headisitbyapp" >
                        <input type="checkbox" id="isitbyapp" name="isitbyapp" onchange="byappchange(this)">&nbsp; Add by application
                    </label>
                    <br>
                    <!--                    <label id="lblcono" hidden="true">Company: &nbsp; </label>
                                        <select name="Conoinp" id="Conoinp" hidden="true" style="width: 140px;">
                                            <option value="" selected="selected">Select Type</option>
                                        </select>-->


                    <label id="lblgroupapp" hidden="true">Group app :&nbsp; </label>
                    <select name="groupapp" id="groupapp" hidden="true" onchange="getrolelist('');" style="width: 140px;">
                        <!--<option value="" selected="selected">Select Type</option>-->
                    </select>
                    <label id="lblapp" hidden="true">App :&nbsp; </label>
                    <select name="Appname" id="Appname" hidden="true" onchange="getrolelist('');" style="width: 140px;">
                        <!--<option value="" selected="selected">Select Type</option>-->
                    </select>
                    <label id="lblrole" hidden="true">Role :&nbsp; </label>
                    <select name="rolelist" id="rolelist" hidden="true" " style="width: 140px;"onchange="" >
                        <option value="" selected="selected">Select Role</option>
                    </select>
                    <br>
                    <div class="row show-grid">
                        <div class="col-md-12 text-center"> 
                            <button type="submit" id="Add" class="btn-success btn-lg">Add Request</button>                       
                            <button type="button" id="Save" class="btn-primary btn-lg" hidden="true">&nbsp;&nbsp;Save&nbsp;&nbsp;</button>
                            <button type="button" id="Send" class="btn-secondary btn-lg" hidden="true" disabled="">Send Request</button>
                            <button type="reset"  id="reset" class="btn-success btn-lg" hidden="true">Reset</button>
                            <br>
                            <input type="checkbox" id="agreementcb" name="checkbox"  onchange="agreementcheck(this)">
                            <label for="checkbox" id="agreementlbl" >ยืนยันว่ารายชื่อดังกล่าว เป็นผู้ใต้ผู้บังคับบัญชา</label>
                        </div>  
                    </div>
                </form>
                <form name="Mail" id="Mail" method="GET" action="./sendmail">
                    <input type="text"  id="reqnoformail" name="reqnoformail" hidden="true">
                    <!--<input type="text"  id="test2" name="test2" hidden="true" value="test">-->
                    <button type="submit" name="SendMail" id="SendMail" value="SendMail" hidden="true"></button>
                </form>
            </div>
        </div>
    </div>
    <br>
    <div id="jsGrid3"></div>
    <br>
    <br>
</div>

<script>
    $("#empcode").select2();
    $('#Xiqma').hide();
    $("#upload").click(function (e) {
        var form = $('#Myform')[0];
        var data = new FormData(form);
        // If you want to add an extra field for the FormData
//        data.append("CustomField", $("#GTA").val());
        $.ajax({
            type: "POST",
            url: "./UploadSignature",
            enctype: 'multipart/form-data',
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            success: function (data) {
//                $("#result").text(data);
                console.log("SUCCESS : ", data);
//                $("#btnSubmit").prop("disabled", false);
            },
            error: function (e) {
//                $("#result").text(e.responseText);
                console.log("ERROR : ", e);
//                $("#btnSubmit").prop("disabled", false);
            }
        });
    });


    window.history.pushState(null, "", window.location.href);
    window.onpopstate = function () {
        window.history.pushState(null, "", window.location.href);
    };

    $('#Myform').keydown(function (e) {
        if (e.keyCode === 13) {
            e.preventDefault();
            return false;
        }
    });

    var search = document.getElementById("empcode");
    search.addEventListener("keyup", function (event) {
        if (event.keyCode === 13) {
//            alert(this.id);
            GetDetail()();
        }
    });
    $(document).ready(function () {
        $.ajax({
            url: "./Sync",
            type: "GET",
            dataType: "json",
            data: {
                page: "Company"
            },
            success: function (getdata) {
                $.each(getdata.data, function (i, obj) {
                    var div_data = "<option value=" + obj.CCCONO + ">" + obj.CCCONO + " : " + obj.CCTX15 + "</option>";
//                        console.log(div_data)
                    $(div_data).appendTo('#vCompany');
                });
            }
        });

        $.ajax({
            url: "./Sync",
            type: "GET",
            dataType: "json",
            data: {
                page: "MailCreator"
            },
            success: function (getdata) {
                $.each(getdata.data, function (i, obj) {
                    var div_data = "<option value=" + obj.ST_EMAIL + ">" + obj.ST_ENAME + " : " + obj.ST_EMAIL + "</option>";
//                    console.log(div_data);
                    $(div_data).appendTo('#MailCreator');
                });
            }
        });

        $.ajax({
            url: "./Sync",
            type: "GET",
            dataType: "json",
            data: {
                page: "EmpCodeList"
            },
            success: function (getdata) {
                $.each(getdata.data, function (i, obj) {
                    var div_data = "<option value=" + obj.ST_CODE + ">" + obj.ST_CODE + "</option>";
//                    console.log(div_data);
                    $(div_data).appendTo('#empcode');
                });
            }
        });
    });


    function clearappgrouprole() {
        $('#Appname').val("");
        $('#groupapp').val("");
        $('#rolelist').empty().append('<option value="" selected="selected">Select role</option>');
//    $('#groupapp').val("");
    }

    function bygroupchange(checkbox) {

        var groupby = document.getElementById("isitgroupby");
        var appby = document.getElementById("isitbyapp");
        if (checkbox.checked) {
            if (groupby.checked === true && appby.checked === true) {
                appby.disabled = false;
                appby.checked = false;
            }
            groupby.disabled = true;
            document.getElementById("lblgroupapp").hidden = false;
            document.getElementById("groupapp").hidden = false;
            document.getElementById("lblapp").hidden = true;
            document.getElementById("Appname").hidden = true;
            document.getElementById("agreementcb").hidden = false;
            document.getElementById("agreementlbl").hidden = false;
        } else {
            if (appby.checked) {
                appby.disabled = true;
                appby.checked = true;
            }
            groupby.disabled = false;
            document.getElementById("lblgroupapp").hidden = true;
            document.getElementById("groupapp").hidden = true;
//            document.getElementById("agreementcb").hidden = false;
//            document.getElementById("agreementlbl").hidden = false;
//            document.getElementById("lblapp").hidden = false;
//            document.getElementById("Appname").hidden = false;
        }
        clearappgrouprole();
    }

    function agreementcheck(checkbox) {
        if (checkbox.checked) {
            console.log(checkbox.checked);
            document.getElementById("Send").disabled = false;
            document.getElementById("Send").classList.remove('btn-secondary');
            document.getElementById("Send").classList.add('btn-danger');
        } else {
            document.getElementById("Send").disabled = true;
            document.getElementById("Send").classList.remove('btn-danger');
            document.getElementById("Send").classList.add('btn-secondary');
            console.log(checkbox.checked);

        }
    }

    function byappchange(checkbox) {
        var groupby = document.getElementById("isitgroupby");
        var appby = document.getElementById("isitbyapp");
//        console.log(appby);
//        console.log(groupby);
        if (checkbox.checked) {
            if (groupby.checked === true && appby.checked === true) {
                groupby.disabled = false;
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
            appby.disabled = false;
            document.getElementById("lblapp").hidden = true;
            document.getElementById("Appname").hidden = true;
//            document.getElementById("lblgroupapp").hidden = false;
//            document.getElementById("groupapp").hidden = false;

        }
//        console.log("add");
        clearappgrouprole();
    }




    function GetDetail() {

        var ST_CODE = document.getElementById("empcode").value;
        document.getElementById("email").value = "";
        document.getElementById("vCompany").value = "";
        document.getElementById("name").value = "";
        document.getElementById("lastname").value = "";
        console.log(ST_CODE);

        $.ajax({
            url: './Sync',
            type: 'GET',
            dataType: 'json',
            data: {
                page: "DetailUser",
                ST_CODE: ST_CODE
            },
            async: false
        }).done(function (response) {

            $.each(response, function (i, obj) {
                var div_ST_CONO = obj.ST_CONO;
                var div_ST_N6L3 = obj.ST_N6L3;
                var div_ST_EMAIL = obj.ST_EMAIL;
                var div_ST_CODE = obj.ST_CODE;


                var div_ST_EPNM = obj.ST_EPNM;
                var div_ST_ENAME = obj.ST_ENAME;
                var div_ST_ELNAME = obj.ST_ELNAME;
                var div_ST_TPNM = obj.ST_TPNM;
                var div_ST_TNAME = obj.ST_TNAME;
                var div_ST_TLNAME = obj.ST_TLNAME;

                document.getElementById("email").value = div_ST_EMAIL;
                document.getElementById("vCompany").value = div_ST_CONO;

                document.getElementById("name").value = div_ST_ENAME;
                document.getElementById("lastname").value = div_ST_ELNAME;
            });
        });

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

//    function testing() {
//        if (document.getElementById("AppAuthorize").checked === true
//                && ((document.getElementById("groupapp").value === "" && document.getElementById("headisitgroupby").checked === true)
//                        || (document.getElementById("Appname").value === "" && document.getElementById("headisitbyapp").checked === true)
//                        || (document.getElementById("rolelist").value === ""))) {
//            console.log("work");
//        } else {
//            console.log("bugged");
//        }
//    }


    function Groupbyname() {
        var authurize = document.getElementById("AppAuthorize").checked;
        var reportauth = document.getElementById("ReportAuthorize").checked;
        var authorreport = "";
        if (authurize) {
            authorreport = "APP";
        } else if (reportauth) {
            authorreport = "REP";
        }
        console.log(authorreport);

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



//    function getconolist() {
//        console.log("test5");
//        $.ajax({
//            url: "./Sync",
//            type: "GET",
//            dataType: "json",
//            data: {
//                page: "getCompany"
//            },
//            success: function (getdata) {
//
//                $.each(getdata, function (i, obj) {
//                    console.log("getdata");
//                    var div_data = "<option value=" + obj.COMPANY + ">" + obj.CCCONO + " : " + obj.CCDIVI + " : " + obj.CCCONM + "</option>";
//                    //console.log(div_data)
//                    $(div_data).appendTo('#Conoinp');
//                });
//            }
//        });
//    }
//    getconolist();


    function getrolelist(role) {
//        console.log("test5");
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





    function GetMaxLine() {

        $.ajax({
            url: './Sync',
            type: 'GET',
            dataType: 'json',
            data: {
                page: "GetMaxLine",
                USREQNO: $("#reqno").val()
            },
            async: false
        }).done(function (response) {

            $.each(response, function (i, obj) {
                var div_LINE = obj.LINE;
                document.getElementById("line").value = div_LINE;
            });
        });

    }
    function check_EN(elm) {
        if (!elm.value.match(/^[a-z ]+$/i) && elm.value.length > 0) {
            alert('กรอกข้อมูลเป็นภาษาอังกฤษเท่านั้น');
        }
    }

    function selecttype(selectline) {
        // Get the checkbox
        var CheckboxNew = document.getElementById("CheckboxNew");
        var CheckboxAddF = document.getElementById("CheckboxAddF");
        var CheckboxDelF = document.getElementById("CheckboxDelF");
        var CheckboxAuth = document.getElementById("AppAuthorize");
        var CheckboxReport = document.getElementById("ReportAuthorize");
        // If the checkbox is checked, display the output text
        if (CheckboxNew.checked === true) {
            document.getElementById("Like").disabled = false;
            document.getElementById("UserType").disabled = false;
            console.log("case1 for new");
        } else {
            if (selectline === false) {
                document.getElementById("Like").value = "";
            }
            document.getElementById("Like").disabled = true;
            document.getElementById("UserType").disabled = true;
            console.log("not case1 for new");
        }

        if (CheckboxAddF.checked === true) {
            document.getElementById("AddFun").disabled = false;
            console.log("case1 for add func");
        } else {
            if (selectline === false) {
                document.getElementById("AddFun").value = "";
            }

            document.getElementById("AddFun").disabled = true;
            console.log("not case1 func");

        }

        if (CheckboxDelF.checked === true) {
            document.getElementById("DelFun").disabled = false;
            console.log("case1 for DelFun");
        } else {
            if (selectline === false) {
                document.getElementById("DelFun").value = "";
            }

            document.getElementById("DelFun").disabled = true;
            console.log("case1 for not DelFun");
        }

        if (CheckboxAuth.checked === true) {
            document.getElementById("headapp").hidden = false;
            document.getElementById("lblapp").hidden = false;
            document.getElementById("Appname").hidden = false;
//            document.getElementById("Conoinp").hidden = false;
//            document.getElementById("lblcono").hidden = false;
            document.getElementById("lblgroupapp").hidden = false;
            document.getElementById("groupapp").hidden = false;
            document.getElementById("isitgroupby").hidden = false;
            document.getElementById("headisitgroupby").hidden = false;
            document.getElementById("isitbyapp").hidden = false;
            document.getElementById("headisitbyapp").hidden = false;
            document.getElementById("lblrole").hidden = false;
            document.getElementById("rolelist").hidden = false;
            document.getElementById("headapp").innerText = "App Authorize";

            var checkboxElement = document.getElementById("isitgroupby");
            var checkboxElement2 = document.getElementById("isitbyapp");
            bygroupchange(checkboxElement);
            byappchange(checkboxElement2);
            console.log("Case1");
        } else if (CheckboxReport.checked === true) {
            document.getElementById("headapp").hidden = false;
            document.getElementById("lblapp").hidden = false;
            document.getElementById("Appname").hidden = false;
//            document.getElementById("Conoinp").hidden = false;
//            document.getElementById("lblcono").hidden = false;
            document.getElementById("lblgroupapp").hidden = false;
            document.getElementById("groupapp").hidden = false;
            document.getElementById("isitgroupby").hidden = false;
            document.getElementById("headisitgroupby").hidden = false;
            document.getElementById("isitbyapp").hidden = false;
            document.getElementById("headisitbyapp").hidden = false;
            document.getElementById("lblrole").hidden = true;
            document.getElementById("rolelist").hidden = true;
            document.getElementById("headapp").innerText = "Report Authorize";

            var checkboxElement = document.getElementById("isitgroupby");
            var checkboxElement2 = document.getElementById("isitbyapp");
            bygroupchange(checkboxElement);
            byappchange(checkboxElement2);
            console.log("Case2");
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
            console.log("Case3");
        }


    }
    selecttype(false);

    function SelectEPR() {

        var radioValue = $("input[name='optionsRadio']:checked").val();
        if (radioValue === "EPR" || radioValue === "ESR" || radioValue === "TARGIT") {
            document.getElementById("lbltype").hidden = false;
            document.getElementById("UserType").hidden = false;
            document.getElementById("Like").hidden = true;
            document.getElementById("lbllike").hidden = true;
            document.getElementById("Like").disabled = false;
            document.getElementById("Like").value = $("#UserType").val();
        } else if (radioValue === "M3INFO") {

            if (document.getElementById("Like").value === "Requester" || document.getElementById("Like").value === "Approval") {
                document.getElementById("Like").value = "";
            }

            document.getElementById("lbltype").hidden = true;
            document.getElementById("UserType").hidden = true;
            document.getElementById("Like").hidden = false;
            document.getElementById("lbllike").hidden = false;
            document.getElementById("Like").disabled = false;
            $("#Like").rules("add", "required");
        } else if (radioValue === "AddOnM3") {
            document.getElementById("lbltype").hidden = true;
            document.getElementById("UserType").hidden = true;
            document.getElementById("Like").hidden = false;
            document.getElementById("lbllike").hidden = false;
            document.getElementById("Like").value = "";
            document.getElementById("Like").disabled = false;
            $("#Like").rules("remove", "required");
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

    function selectgroup() {

        var radioValue = $("input[name='optionsRadio']:checked").val();
        if (radioValue === "AddOnM3") {
            document.getElementById("CheckboxNew").checked = true;
            document.getElementById("CheckboxAddF").checked = false;
            document.getElementById("CheckboxDelF").checked = false;
//            document.getElementById("Like").disabled = false;
            selecttype(false);
            document.getElementById("CheckboxAddF").disabled = true;
            document.getElementById("CheckboxDelF").disabled = true;
            document.getElementById("AppAuthorize").disabled = false;
            document.getElementById("ReportAuthorize").disabled = false;
            SelectEPR();
//            console.log("Test1");
        } else if (radioValue !== "M3INFO" && radioValue !== "EPR" && radioValue !== "ESR") {

            document.getElementById("CheckboxNew").checked = true;
            document.getElementById("CheckboxAddF").checked = false;
            document.getElementById("CheckboxDelF").checked = false;
            selecttype(false);
            document.getElementById("CheckboxAddF").disabled = true;
            document.getElementById("CheckboxDelF").disabled = true;
            document.getElementById("AppAuthorize").disabled = true;
            document.getElementById("ReportAuthorize").disabled = true;
            SelectEPR();
//            console.log("Test2");
        } else if (radioValue === "EPR" || radioValue === "ESR") {
            document.getElementById("CheckboxNew").checked = true;
            document.getElementById("CheckboxAddF").checked = false;
            document.getElementById("CheckboxDelF").checked = false;
            selecttype(false);
            document.getElementById("CheckboxAddF").disabled = true;
            document.getElementById("CheckboxDelF").disabled = true;
            SelectEPR();
            document.getElementById("AppAuthorize").disabled = true;
            document.getElementById("ReportAuthorize").disabled = true;

//            console.log("Test3");
        } else {
            document.getElementById("CheckboxNew").disabled = false;
            document.getElementById("CheckboxAddF").disabled = false;
            document.getElementById("CheckboxDelF").disabled = false;
            document.getElementById("AppAuthorize").disabled = true;
            document.getElementById("AppAuthorize").checked = false;
            document.getElementById("CheckboxNew").checked = true;
            document.getElementById("ReportAuthorize").disabled = true;
            document.getElementById("ReportAuthorize").checked = false;

            selecttype(false);
            SelectEPR();
//            console.log("Test4");
        }
    }

//MY FORM
    $("#Myform").validate({
        rules: {
            name: "required",
            lastname: "required",
            Company: "required",
            MailCreator: "required",
            Like: "required",
            AddFun: "required",
            DelFun: "required",
            UserType: "required",
            groupapp: "required",
            Appname: "required",
            rolelist: "required"
        },
        messages: {
            name: "Please specify your name",
            lastname: "Please specify your lastname",
            Company: " Please specify company",
            MailCreator: "Please specify creator",
            Like: {
                required: function (element) {
                    if (document.getElementById("CheckboxNew").checked === true && document.getElementById("Like").value === "" && document.getElementById("M3INFO").checked === true) {
                        return  "Please specify your user reference";
                    }
                }
            },
            AddFun: {
                required: function (element) {
                    if (document.getElementById("CheckboxAddF").checked === true && document.getElementById("AddFun").value === "") {
                        return  "Please specify your function";
                    }
                }
            },
            DelFun: {
                required: function (element) {
                    if (document.getElementById("CheckboxDelF").checked === true && document.getElementById("DelFun").value === "") {
                        return  "Please specify your function";
                    }
                }
            },
            UserType: {
                required: function (element) {
                    if (document.getElementById("UserType").value === "" && (document.getElementById("EPR").checked === true || document.getElementById("ESR").checked === true)) {
                        return  "Please specify your type";
                    }
                }
            },
            groupapp: {

                required: function (element) {
                    if ((document.getElementById("AppAuthorize").checked === true || document.getElementById("ReportAuthorize").checked === true) && document.getElementById("groupapp").value === "")
                    {
                        return  "Please Select Group";
                    }
                }

            },
            Appname: {

                required: function (element) {
                    if ((document.getElementById("AppAuthorize").checked === true || document.getElementById("ReportAuthorize").checked === true) && document.getElementById("Appname").value === "")
                    {
                        return  "Please Select app";
                    }
                }

            },
            rolelist: {

                required: function (element) {
                    if (document.getElementById("AppAuthorize").checked === true && document.getElementById("rolelist").value === "")
                    {
                        return  "Please Select Group";
                    }
                }

            }
        },
        submitHandler: function () {
            event.preventDefault();
            var found = "0";
            var reqno = document.getElementById("reqno").value;
            var line = document.getElementById("line").value;
            var USREQ = "<%out.print(session.getAttribute("namereq"));%>";
//            console.log(USREQ);
            var radioValue = $("input[name='optionsRadio']:checked").val();
            var type = [];
            $.each($("input[name='checkboxinline']:checked"), function () {
                type.push($(this).val());
            });
            var empcode1 = $("#empcode").val();
            var checkusercreaterequest = "0";
            let preventSubmit = false;
            $.ajax({
                url: './Sync',
                type: 'GET',
                dataType: 'text',
                data: {
                    page: "CheckRequestCreatedByUser",
                    USCOMP: $("#vCompany").val(),
                    Empcode: empcode1
                },
                async: false
            }).done(function (response) {
                console.log(response);
                if (USREQ === response) {
                    alert("You cannot created request for yourself,Please request by user's head.");
                     preventSubmit = true; // set guard flag
                    return false;
                }
            });
            if (preventSubmit) return false;
            if (reqno === "") {
                $.ajax({
                    url: './Sync',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        page: "GET_REQNO"
                    },
                    async: false
                }).done(function (response) {

                    $.each(response, function (i, obj) {
                        var div_REQNO = obj.reqno;
                        document.getElementById("reqno").value = div_REQNO;
                    });
                });
            }


            var Inserttype = type.join(",");
            var count = "";
            $.ajax({
                url: './Sync',
                type: 'GET',
                dataType: 'json',
                data: {
                    page: "Check_Duplicate",
                    USREQNO: $("#reqno").val(),
                    USCOMP: $("#vCompany").val(),
                    USCODE: $("#empcode").val(),
                    USGROUP: radioValue,
                    USTYPE: Inserttype,
                    USGROUPAPP: $("#groupapp").val(),
                    USAPP: $("#Appname").val(),
                    USROLE: $("#rolelist").val()
                },
                async: false
            }).done(function (response) {
                $.each(response, function (i, obj) {
                    var Duplicate = obj.Duplicate;
                    count = Duplicate;
                });
            });

            var CheckUserM3 = "0";
            console.log('type' + Inserttype);
            if (Inserttype === "New") {
                $.ajax({
                    url: './Sync',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        page: "CheckUserM3",
                        USCODE: $("#empcode").val(),
                        USCOMP: $("#vCompany").val(),
                        USGROUP: radioValue,
                        USTYPE: Inserttype,
                        USLIKE: $("#Like").val()
                    },
                    async: false
                }).done(function (response) {
                    $.each(response, function (i, obj) {
                        console.log(response);
                        var div_UserM3 = obj.CheckUserM3;
                        CheckUserM3 = div_UserM3;
                    });
                });



                var empcode = $("#empcode").val();
                var checkExistUser = 1;
                $.ajax({
                    url: './Sync',
                    type: 'GET',
                    dataType: 'text',
                    data: {
                        page: "checkExistUserbyempcode",
                        empcode: empcode


                    },
                    async: false
                }).done(function (response) {

                    checkExistUser = response;

                });
            }

            if (Inserttype === "AppAuthorize") {
                console.log("AppAuthorize");
                var isitgroupby = document.getElementById("isitgroupby").checked;
                var isitbyapp = document.getElementById("isitbyapp").checked;
                var mode2 = '';
                var apporrep = 'APP';
                if (isitgroupby) {
                    mode2 = 'Bygroup';
                    console.log(isitgroupby);
                } else if (isitbyapp) {
                    mode2 = 'Byapp';
                    console.log(isitbyapp);
                } else {
                    console.log("bugged");
                }

                $.ajax({
                    url: './Sync',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        page: "checkExistRole",
                        cono: $("#vCompany").val(),
                        usercode: $("#empcode").val(),
                        groupapp: $("#groupapp").val(),
                        app: $("#Appname").val(),
                        role: $("#rolelist").val(),
                        mode: mode2,
                        apporrep: 'APP'
                    },
                    async: false
                }).done(function (response) {
                    $.each(response, function (i, obj) {
                        console.log(response);
                        found = obj.AMOUNT;
                    });

                });
            } else if (Inserttype === "ReportAuthorize") {
                console.log("ReportAuthorize");
                var isitgroupby = document.getElementById("isitgroupby").checked;
                var isitbyapp = document.getElementById("isitbyapp").checked;
                var mode = '';
                var apporrep = 'APP';
                if (isitgroupby) {
                    mode = 'Bygroup';
                    console.log(isitgroupby);
                } else if (isitbyapp) {
                    mode = 'Byapp';
                    console.log(isitbyapp);
                } else {
                    console.log("bugged");
                }
                $.ajax({
                    url: './Sync',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        page: "checkExistRole",
                        cono: $("#vCompany").val(),
                        usercode: $("#empcode").val(),
                        groupapp: $("#groupapp").val(),
                        app: $("#Appname").val(),
                        role: $("#rolelist").val(),
                        mode: mode,
                        apporrep: 'REP'
                    },
                    async: false
                }).done(function (response) {
                    $.each(response, function (i, obj) {
                        console.log(response);
                        found = obj.AMOUNT;
                    });
                });
            }
//Insert table
//            if(checkExistUser !== 0 && document.getElementById("AddOnM3").checked == true){
//                 alert("This username already exist. Please try another employee No. or reset password.  ");
//                return false;
//            }
            if (found !== "0") {
                alert("role already assigned");
                 preventSubmit = true; // set guard flag
                return false;
            } else
            if (count !== "0") {
                alert("Duplicate detail !!");
                 preventSubmit = true; // set guard flag
                return false;
            } else if ((CheckUserM3 !== "0" && Inserttype === "New")) {
                alert("Can not request. You already have request in company " + $("#vCompany option:selected").text());
                 preventSubmit = true; // set guard flag
                return false;
            } else if ((USREQ === "M3SRVICT" && radioValue === "M3INFO")) {
                alert("Can not request. Please request by user's head.");
                 preventSubmit = true; // set guard flag
                return false;
            } else {

                $.ajax({
                    url: './Sync',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        page: "InsertRequest",
                        USREQNO: $("#reqno").val(),
                        USLINE: $("#line").val(),
                        USCOMP: $("#vCompany").val(),
                        USNAME1: $("#name").val(),
                        USNAME2: $("#lastname").val(),
                        USCODE: $("#empcode").val(),
                        USMAIL: $("#email").val(),
                        USGROUP: radioValue,
                        USTYPE: Inserttype,
                        USLIKE: $("#Like").val(),
                        USAFUNC: $("#AddFun").val(),
                        USDFUNC: $("#DelFun").val(),
                        USUREQ: USREQ,
                        USEMCRE: $("#MailCreator").val(),
                        USGROUPAPP: $("#groupapp").val(),
                        USAPP: $("#Appname").val(),
                        USROLE: $("#rolelist").val()
                    },
                    async: false
                }).done(function (response) {

                });
                       if (preventSubmit) return false;
//
//
//                var fullPath = document.getElementById('File').value;
//                if (fullPath) {
//                    var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
//                    var filename = fullPath.substring(startIndex);
//                    if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
//                        filename = filename.substring(1);
//                    }
//                    alert(filename);
//                }
                // If you want to add an extra field for the FormData
//        data.append("CustomField", $("#GTA").val());

                if ($("#File").val() !== "") {
                    var form = $('#Myform')[0];

                    var data = new FormData(form);
                    data.append("USREQNO", $("#reqno").val());
                    data.append("USLINE", $("#line").val());


                    var fullPath = document.getElementById('File').value;
                    if (fullPath) {
                        var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
                        var filename = fullPath.substring(startIndex);
                        if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
                            filename = filename.substring(1);
                        }
                    }
                    data.append("filename", filename);

                    $.ajax({
                        type: "POST",
                        url: "./UploadFile",
                        enctype: 'multipart/form-data',
                        data: data,
                        processData: false,
                        contentType: false,
                        cache: false,
                        success: function (data) {
                            console.log("SUCCESS : ", data);
                        },
                        error: function (e) {
                            console.log("ERROR : ", e);
                        }
                    });
//
                    console.log(data);
                }

//            $("#jsGrid3").jsGrid("loadData");
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
//                            $("#reset").click();
                            GetMaxLine();
                            line--;
                            document.getElementById("line").value = line;
                            document.getElementById("Save").hidden = true;
                            document.getElementById("Add").hidden = false;
                            console.log(line);
                            if (line === 1) {

                                document.getElementById("Send").hidden = true;
                                document.getElementById("M3INFO").disabled = false;
                                document.getElementById("TARGIT").disabled = false;
                                document.getElementById("CRM").disabled = false;
                                document.getElementById("ReportAuthorize").disabled = false;
                                document.getElementById("AppAuthorize").disabled = false;
                            }

                            $("#Add").show();
//                            $("#Send").show();
                            $("#Save").hide();
//                            selectgroup();
//                            document.getElementById("AddFun").disabled = true;
//                            document.getElementById("DelFun").disabled = true;
//                            document.getElementById("MailCreator").value = "";
                        }
                    },
                    fields: [
                        {type: "control", editButton: false, deleteButton: true, width: 50},
                        {title: "REQNO", name: "USREQNO", type: "text", editing: false, align: "center", width: 75},
                        {title: "Line", name: "USLINE", type: "text", align: "center", width: 50},
                        {title: "Company", name: "USCOMP", type: "text", align: "center", width: 80, editing: true},
                        {title: "Code", name: "USCODE", type: "text", editing: false, align: "center", width: 75},
                        {title: "Name", name: "USNAME1", type: "text", align: "left"},
                        {title: "Last Name", name: "USNAME2", type: "text", align: "left", width: 150},
                        {title: "E-Mail", name: "USMAIL", type: "text", align: "left", width: 250},
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
                        showDetailsDialog1("GET", args.item);
                    }
                });
                alert("Add request complete.");
//                $("#reset").click();
//                $("#empcode").val('').trigger('change');
//                document.getElementById("MailCreator").value = "";
                line++;
                document.getElementById("line").value = line;
                document.getElementById("Send").hidden = false;
                document.getElementById("reqnoformail").value = "" + $("#reqno").val();
                if (Inserttype === "AppAuthorize") {
                    document.getElementById("M3INFO").disabled = true;
                    document.getElementById("TARGIT").disabled = true;
                    document.getElementById("CRM").disabled = true;
                    document.getElementById("ReportAuthorize").disabled = true;
                } else if (Inserttype === "ReportAuthorize") {
                    document.getElementById("M3INFO").disabled = true;
                    document.getElementById("TARGIT").disabled = true;
                    document.getElementById("CRM").disabled = true;
                    document.getElementById("AppAuthorize").disabled = true;
                }
//                document.getElementById("AddFun").disabled = true;
//                document.getElementById("DelFun").disabled = true;
//                selectgroup();
            }
        }

    });


    var showDetailsDialog1 = function (dialogType, client) {
        clearappgrouprole();
        var input = "" + client.USTYPE;
        document.getElementById("Save").hidden = false;
        var fields = input.split(',');
        var Like = client.USLIKE;
        var AddFunc = client.USAFUNC;
        var DelFunc = client.USDFUNC;
        var App = client.USAPP;
        var Groupapp = client.USGROUPAPP;
        var Role = client.USROLE;
        document.getElementById("Like").value = Like;
        document.getElementById("AddFun").value = AddFunc;
        document.getElementById("DelFun").value = DelFunc;
//        var CheckboxAuth = document.getElementById("AppAuthorize");
//        var CheckboxReport = document.getElementById("ReportAuthorize");
        $("#reqno").val(client.USREQNO);
        $("#line").val(client.USLINE);
        $("#empcode").select2().val(client.USCODE).trigger("change");
        $("#MailCreator").val(client.USEMCRE);
        document.getElementById("name").value = client.USNAME1;
        document.getElementById("lastname").value = client.USNAME2;
        document.getElementById("email").value = client.USMAIL;
//        document.getElementById("groupapp").value = Groupapp;
//        document.getElementById("Appname").value = App;
//        document.getElementById("Appname").value = client.App;
//console.log
        $("#Send").hide();
        $("#Add").hide();
        $("#Save").show();
        $("#TYPEGROUP :input").prop("disabled", true);
        $("#fordisable :input").prop("disabled", true);
        $("#vCompany").val(client.USCOMP);

        $('input[name="checkboxinline"]').each(function () {
            this.checked = false;
        });
        document.getElementById("UserType").disabled = false;

        if (client.USGROUP === "Xiqma") {
            document.getElementById("Xiqma").checked = true;
        } else if (client.USGROUP === "AddOnM3") {
            document.getElementById("AddOnM3").checked = true;
        } else if (client.USGROUP === "EPR") {
            document.getElementById("EPR").checked = true;
            document.getElementById("UserType").disabled = false;
            document.getElementById("UserType").value = client.USLIKE;
        } else if (client.USGROUP === "ESR") {
            document.getElementById("ESR").checked = true;
            document.getElementById("UserType").disabled = false;
            document.getElementById("UserType").value = client.USLIKE;
        } else if (client.USGROUP === "CRM") {
            document.getElementById("CRM").checked = true;
        } else if (client.USGROUP === "M3INFO") {
            document.getElementById("M3INFO").checked = true;
        }
        selectgroup();
        for (var i = 0; i < 3; i++) {
            var type = fields[i];
            if (type === "New" && client.USGROUP !== "M3INFO" && (client.USGROUP !== "ESR" && client.USGROUP !== "EPR")) {
                document.getElementById("lbltype").hidden = true;
                document.getElementById("UserType").hidden = true;
                document.getElementById("Like").hidden = false;
                document.getElementById("lbllike").hidden = false;

                document.getElementById("CheckboxNew").checked = true;
                document.getElementById("Like").disabled = true;
                document.getElementById("CheckboxNew").disabled = false;
                document.getElementById("CheckboxAddF").disabled = true;
                document.getElementById("CheckboxDelF").disabled = true;
                if (type === "AddOnM3") {
                    document.getElementById("AppAuthorize").disabled = false;
                    document.getElementById("ReportAuthorize").disabled = false;
                }

            } else if (type === "New" && client.USGROUP === "M3INFO") {
                document.getElementById("lbltype").hidden = true;
                document.getElementById("UserType").hidden = true;
                document.getElementById("Like").hidden = false;
                document.getElementById("lbllike").hidden = false;

                document.getElementById("CheckboxNew").checked = true;
                document.getElementById("Like").disabled = false;
                document.getElementById("CheckboxNew").disabled = false;

            } else if (type === "AddFunc" && client.USGROUP === "M3INFO") {
                document.getElementById("lbltype").hidden = true;
                document.getElementById("UserType").hidden = true;
                document.getElementById("Like").hidden = false;
                document.getElementById("lbllike").hidden = false;

                document.getElementById("CheckboxAddF").checked = true;
                document.getElementById("AddFun").disabled = false;
                document.getElementById("CheckboxAddF").disabled = false;

            } else if (type === "DelFunc" && client.USGROUP === "M3INFO") {
                document.getElementById("lbltype").hidden = true;
                document.getElementById("UserType").hidden = true;
                document.getElementById("Like").hidden = false;
                document.getElementById("lbllike").hidden = false;

                document.getElementById("CheckboxDelF").checked = true;
                document.getElementById("DelFun").disabled = false;
                document.getElementById("CheckboxDelF").disabled = false;
                document.getElementById("File").disabled = false;
                document.getElementById("File").hidden = false;

            } else if (type === "New" && (client.USGROUP === "ESR" || client.USGROUP === "EPR")) {
                document.getElementById("CheckboxNew").checked = true;
                document.getElementById("CheckboxAddF").disabled = true;
                document.getElementById("CheckboxDelF").disabled = true;
                document.getElementById("lbltype").hidden = false;
                document.getElementById("UserType").hidden = false;
                document.getElementById("UserType").disabled = false;
                document.getElementById("UserType").value = Like;
                document.getElementById("Like").hidden = true;
                document.getElementById("lbllike").hidden = true;
                document.getElementById("Like").disabled = false;
                document.getElementById("Like").value = Like;
//                document.getElementById("agreementlbl").hidden = false;
//                document.getElementById("agreementcb").hidden = false;
            } else if (type === "AppAuthorize")
            {
                document.getElementById("AppAuthorize").checked = true;
//                selecttype(false);
                if (App === "") {
                    $("#isitgroupby").prop("checked", true);
                    $("#isitbyapp").prop("checked", false);
                } else if (Groupapp === "") {
                    $("#isitbyapp").prop("checked", true);
                    $("#isitgroupby").prop("checked", false);
                }
                $("#AppAuthorize").trigger('onclick');
                document.getElementById("Appname").value = App;
                document.getElementById("groupapp").value = Groupapp;
                getrolelist(Role);
                console.log('App' + App);
                console.log('groupapp' + Groupapp);
//                document.getElementById("").value = Role;
//                $("#rolelist").val(Role);

//                console.log(Role);
            } else if (type === "ReportAuthorize")
            {
                document.getElementById("ReportAuthorize").checked = true;
                selecttype(false);
                if (App === "") {
                    $("#isitgroupby").prop("checked", true);
                    $("#isitbyapp").prop("checked", false);
                } else if (Groupapp === "") {
                    $("#isitbyapp").prop("checked", true);
                    $("#isitgroupby").prop("checked", false);
                }

                $("#ReportAuthorize").trigger('onclick');
                document.getElementById("Appname").value = App;
                console.log('App' + App);
                document.getElementById("groupapp").value = Groupapp;
                console.log('groupapp' + Groupapp);
                getrolelist(Role);
//                $("#rolelist").val(Role);
//                console.log(Role);
            }
            if (client.USGROUP === "AddOnM3") {
                document.getElementById("AppAuthorize").disabled = false;
                document.getElementById("ReportAuthorize").disabled = false;
            }
        }
        selecttype(true);

    };




    $("#Save").click(function (e) {

        var answer = window.confirm("Do you want to update detail request " + $("#reqno").val());
        var radioValue = $("input[name='optionsRadio']:checked").val();
        var ST_CODE = document.getElementById("empcode").value;
        var type = [];
        $.each($("input[name='checkboxinline']:checked"), function () {
            type.push($(this).val());
        });
        var Inserttype = type.join(",");
        if (answer === true) {
            $.ajax({
                url: './Sync',
                type: 'POST',
                dataType: 'json',
                data: {
                    page: "Update_LineReq",
                    USREQNO: $("#reqno").val(),
                    USLINE: $("#line").val(),
                    USCOMP: $("#vCompany").val(),
                    USNAME1: $("#name").val(),
                    USNAME2: $("#lastname").val(),
                    USMAIL: $("#email").val(),
                    USCODE: ST_CODE,
                    USGROUP: radioValue,
                    USTYPE: Inserttype,
                    USLIKE: "" + $("#Like").val(),
                    USAFUNC: "" + $("#AddFun").val(),
                    USDFUNC: "" + $("#DelFun").val(),
                    USEMCRE: $("#MailCreator").val(),
                    USAPP: $("#Appname").val(),
                    USGROUPAPP: $("#groupapp").val(),
                    USROLE: $("#rolelist").val()
                },
                async: false
            }).done(function (response) {


            });

            if ($("#File").val() !== "") {
                var form = $('#Myform')[0];
                var data = new FormData(form);
                var data = new FormData(form);
                data.append("USREQNO", $("#reqno").val());
                data.append("USLINE", $("#line").val());


                var fullPath = document.getElementById('File').value;
                if (fullPath) {
                    var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
                    var filename = fullPath.substring(startIndex);
                    if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
                        filename = filename.substring(1);
                    }
                }
                data.append("filename", filename);


                $.ajax({
                    type: "POST",
                    url: "./UploadFile",
                    enctype: 'multipart/form-data',
                    data: data,
                    processData: false,
                    contentType: false,
                    cache: false,
                    success: function (data) {
                        console.log("SUCCESS : ", data);
                    },
                    error: function (e) {
                        console.log("ERROR : ", e);
                    }
                });
//
                console.log(data);
            }

            $("#jsGrid3").jsGrid("loadData");
            alert("Update data complete.");
            $("#empcode").val('').trigger('change');
        } else {
            return false;
        }
        console.log("Disappear");
        $("#reset").click();
        $("#Save").hide();
        $("#Add").show();
        $("#Send").show();

//        $("#agreementlbl").hide();
//         $("#agreementcb").hide();
        GetMaxLine();
        selectgroup();
        document.getElementById("AddFun").disabled = true;
        document.getElementById("DelFun").disabled = true;
        document.getElementById("MailCreator").value = "";
    });

    $("#Send").click(function (e) {

        var answer = window.confirm("Do you want to send  request " + $("#reqno").val());
        if (answer === true) {
            $.ajax({
                url: './Sync',
                type: 'POST',
                dataType: 'json',
                data: {
                    page: "SendToCreate",
                    USREQNO: $("#reqno").val()
                },
                async: false
            }).done(function (response) {

            });
            alert("Send request complete !!");
            $("#SendMail").click();
        } else {
            return false;
        }
    });

    $('#Like').on('input', function (evt) {
        $(this).val(function (_, val) {
            return val.toUpperCase();
        });
    });
    $('#AddFun').on('input', function (evt) {
        $(this).val(function (_, val) {
            return val.toUpperCase();
        });
    });
    $('#DelFun').on('input', function (evt) {
        $(this).val(function (_, val) {
            return val.toUpperCase();

        });
    });


</script>

