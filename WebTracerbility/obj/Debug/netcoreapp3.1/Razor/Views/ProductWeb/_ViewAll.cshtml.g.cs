#pragma checksum "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "85ea566ab8df48787fefdaab3bac521d2b956fa4"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_ProductWeb__ViewAll), @"mvc.1.0.view", @"/Views/ProductWeb/_ViewAll.cshtml")]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"85ea566ab8df48787fefdaab3bac521d2b956fa4", @"/Views/ProductWeb/_ViewAll.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"39fa8d7a043781c4d1ac14f3c71d24cf4a00e4b9", @"/Views/_ViewImports.cshtml")]
    public class Views_ProductWeb__ViewAll : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<Products>>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "DeleteProduct", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-controller", "ProductWeb", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_2 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("onsubmit", new global::Microsoft.AspNetCore.Html.HtmlString("return jQueryAjaxDelete(this)"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
#nullable restore
#line 5 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
  
    var data = ViewBag.Message;
    bool check = false;
    DateTime? date = null;

#line default
#line hidden
#nullable disable
            WriteLiteral(@"
<!-- /.row -->
<div class=""row"">
    <div class=""col-12"">
        <div class=""card"">
            <div class=""card-header"">
                List Products

                <div class=""card-tools"">
                    <div class=""input-group input-group-sm"" style=""width: 150px"">
                        <div class=""input-group-lg"">
                            <button");
            BeginWriteAttribute("onclick", " onclick=\"", 623, "\"", 734, 4);
            WriteAttributeValue("", 633, "showInPopup(\'", 633, 13, true);
#nullable restore
#line 21 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
WriteAttributeValue("", 646, Url.Action("CreateProduct", "ProductWeb",null, Context.Request.Scheme), 646, 71, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 717, "\',\'News", 717, 7, true);
            WriteAttributeValue(" ", 724, "Product\')", 725, 10, true);
            EndWriteAttribute();
            WriteLiteral(@" type=""button"" class=""btn btn-success"">Add Product</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.card-header -->
            <div class=""card-body table-responsive p-0"">
                <table class=""table table-hover text-nowrap"">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Efg Date</th>
                            <th>Exp Date</th>
                            <th>Manufactured Name</th>
                            <th>Detail</th>
                            <th>Action</th>

                        </tr>
                    </thead>
                    <tbody>
");
#nullable restore
#line 42 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                         foreach (var item in Model)
                        {

#line default
#line hidden
#nullable disable
            WriteLiteral("                            <tr>\r\n                                <td> ");
#nullable restore
#line 45 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                                Write(Html.DisplayFor(modelItem=>item.IdProduct));

#line default
#line hidden
#nullable disable
            WriteLiteral(" </td>\r\n                                <td> ");
#nullable restore
#line 46 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                                Write(Html.DisplayFor(modelItem=>item.NameProduct));

#line default
#line hidden
#nullable disable
            WriteLiteral(" </td>\r\n                                <td> ");
#nullable restore
#line 47 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                                Write(Html.DisplayFor(modelItem=>item.ManufacturedDate));

#line default
#line hidden
#nullable disable
            WriteLiteral(" </td>\r\n                                <td> ");
#nullable restore
#line 48 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                                Write(Html.DisplayFor(modelItem=>item.ExpiredDate));

#line default
#line hidden
#nullable disable
            WriteLiteral(" </td>\r\n                                <td> ");
#nullable restore
#line 49 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                                Write(Html.DisplayFor(modelItem=>item.Manufactured));

#line default
#line hidden
#nullable disable
            WriteLiteral(" </td>\r\n                                <td> ");
#nullable restore
#line 50 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                                Write(Html.DisplayFor(modelItem=>item.Details));

#line default
#line hidden
#nullable disable
            WriteLiteral(" </td>\r\n                                <td class=\"text-right py-0 align-middle\">\r\n                                    <div class=\"btn-group btn-group-sm\">\r\n                                        <a");
            BeginWriteAttribute("onclick", " onclick=\"", 2386, "\"", 2529, 4);
            WriteAttributeValue("", 2396, "showInPopup(\'", 2396, 13, true);
#nullable restore
#line 53 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
WriteAttributeValue("", 2409, Url.Action("CreateProduct", "ProductWeb",new { id = item.IdProduct.Trim() }, Context.Request.Scheme), 2409, 101, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 2510, "\',\'Update", 2510, 9, true);
            WriteAttributeValue(" ", 2519, "Product\')", 2520, 10, true);
            EndWriteAttribute();
            WriteLiteral(" class=\"btn btn-info\"><i class=\"fas fa-edit\"></i></a>\r\n");
            WriteLiteral("                                        ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("form", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "85ea566ab8df48787fefdaab3bac521d2b956fa49545", async() => {
                WriteLiteral("\r\n                                            <button type=\"submit\" class=\"btn btn-danger\"><i class=\"fa fa-trash\"></i></button>\r\n                                        ");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Action = (string)__tagHelperAttribute_0.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_0);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Controller = (string)__tagHelperAttribute_1.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_1);
            if (__Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.RouteValues == null)
            {
                throw new InvalidOperationException(InvalidTagHelperIndexerAssignment("asp-route-id", "Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper", "RouteValues"));
            }
            BeginWriteTagHelperAttribute();
#nullable restore
#line 55 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                                                                                                       WriteLiteral(item.IdProduct.Trim());

#line default
#line hidden
#nullable disable
            __tagHelperStringValueBuffer = EndWriteTagHelperAttribute();
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.RouteValues["id"] = __tagHelperStringValueBuffer;
            __tagHelperExecutionContext.AddTagHelperAttribute("asp-route-id", __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.RouteValues["id"], global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_2);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n                                        \r\n                                    </div>\r\n                                </td>\r\n\r\n                            </tr>\r\n");
#nullable restore
#line 63 "D:\Data\FLutter\Project\BidPhar_services\Views\ProductWeb\_ViewAll.cshtml"
                        }

#line default
#line hidden
#nullable disable
            WriteLiteral("                    </tbody>\r\n                </table>\r\n            </div>\r\n            <!-- /.card-body -->\r\n        </div>\r\n        <!-- /.card -->\r\n    </div>\r\n</div>\r\n\r\n\r\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<IEnumerable<Products>> Html { get; private set; }
    }
}
#pragma warning restore 1591
