#pragma checksum "D:\Data\FLutter\Project\BidPhar_services\Views\Tracking\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "030ad681525fb5d30ef39cc0546fc4caac6c71f7"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Tracking_Index), @"mvc.1.0.view", @"/Views/Tracking/Index.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "D:\Data\FLutter\Project\BidPhar_services\Views\_ViewImports.cshtml"
using BidPhar_services;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "D:\Data\FLutter\Project\BidPhar_services\Views\_ViewImports.cshtml"
using BidPhar_services.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"030ad681525fb5d30ef39cc0546fc4caac6c71f7", @"/Views/Tracking/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"39fa8d7a043781c4d1ac14f3c71d24cf4a00e4b9", @"/Views/_ViewImports.cshtml")]
    public class Views_Tracking_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral(@"    <div class=""col-md-12"">
        <div class=""row"">
            <div class=""col-md-6"">
                <div class=""card"">
                    <!-- /.card-header -->
                    <div class=""card-body"">
                        <div class=""row"">
                            <div class=""col-sm-12 col-md-6"">
                                <h3 class=""card-title"">List Transaction of product</h3>
                            </div>
                            <div class=""col-sm-12 col-md-6"">
                                <div class=""card-tools"">
                                    <div class=""input-group input-group-sm"">
                                        <input type=""text"" id=""table_search"" class=""form-control float-right"" placeholder=""Search"">

                                        <div class=""input-group-append"">
                                            <a id=""search_trans"" class=""btn btn-default""><i class=""fa fa-search""></i></a>
                                        </div>
            WriteLiteral(@"
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class=""row"">
                            <div class=""col-sm-12"">
                                <table class=""table"">
                                    <thead>
                                        <tr>
                                            <th style=""width: 10px""></th>
                                            <th>Tracing Data</th>
                                            <th style=""width: 40px"">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id=""tr_showTrans"">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                    </div>
                    <!-- /.card-body -");
            WriteLiteral(@"->
                </div>
                <!-- /.card -->
            </div>
            <div class=""col-md-6"">
                <p class=""lead"">Product Code: <i id=""prodid""></i></p>

                <div class=""table-responsive"">
                    <table class=""table"">
                        <tbody>
                            <tr>
                                <th style=""width:50%"">Name Product:</th>
                                <td id=""prodname"">*</td>
                            </tr>
                            <tr>
                                <th>Manufactured Date:</th>
                                <td id=""manudate"">*</td>
                            </tr>
                            <tr>
                                <th>Expired Date</th>
                                <td id=""expdate"">*</td>
                            </tr>
                            <tr>
                                <th>Product of </th>
                                <td id=""manuname"">*<");
            WriteLiteral("/td>\r\n                            </tr>\r\n                        </tbody>\r\n                    </table>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591