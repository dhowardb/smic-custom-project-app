"use strict";sap.ui.define(["sap/m/MessageToast"],function(e){"use strict";function t(e){}var r=function t(r){try{var a=this;if(!n(a.getModel("ui"))){e.show("Cannot post any content in Display Mode");return Promise.resolve()}var i=a.editFlow;var o=i.getV+
iew();var s=r.getSource();var d=r.getMetadata();var v=o.byId("projectsdemoappv2.projectsdemoappv2::ProjectsObjectPage--fe::CustomSubSection::FeedContent--feedsList");var l={Content:r.getParameter("value")};var u=v.getBinding("items");u.create(l);return P+
romise.resolve()}catch(e){return Promise.reject(e)}};function a(t){if(!n(this.getModel("ui"))){e.show("Cannot delete any content in Display Mode");return}var r=this.editFlow;var a=r.getView();var i=t.getParameter("item");var o=i.sId;var s=a.byId(o);var d+
=s.getBindingContext();d["delete"]()}function i(t){if(!n(this.getModel("ui"))){e.show("Cannot edit any content in Display Mode");return}e.show("Updating...");var r=this.editFlow;var a=r.getView();var i=t.getParameter("item");var o=i.sId;var s=a.byId(o);v+
ar d=s.getBindingContext();var v=d.getBinding();var l={Content:t.getParameter("value")}}function n(e){if(!e){return false}var t=e.bindList("/isEditable");var r=t.getModel();var a=r.getData();var i=a.editMode;var n={display:"Display",editable:"Editable"};+
if(i===n.display){return false}else{return true}}var o={__esModule:true};o.onPress=t;o.onPost=r;o.onPressDelete=a;o.onPressEdit=i;o.isEditingAllowed=n;return o});                                                                                             
//# sourceMappingURL=FeedContent.js.map                                                                                                                                                                                                                        