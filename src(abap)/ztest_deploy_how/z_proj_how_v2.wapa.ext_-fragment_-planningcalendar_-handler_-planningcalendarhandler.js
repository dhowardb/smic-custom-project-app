"use strict";sap.ui.define(["sap/m/MessageToast"],function(e){"use strict";var t=function t(n,o){try{var r=this;var a=n.getParameter("appointment");var i=r.loadFragment({name:"projectsdemoappv2.projectsdemoappv2.ext.fragment.PlanningCalendar.views.Calend+
arDetails",controller:r,id:"",contextPath:"",initialBindingContext:o});i.then(function(t){var n;if(!a){e.show("Appointment selected is not booked or blank!");return}n=a.getBindingContext();var o=t;o.setBindingContext(n).openBy(a)});return Promise.resolve+
()}catch(e){return Promise.reject(e)}};function n(t){e.show("Zoom in not yet avalaible in current version")}function o(t){e.show("Zoom out not yet avalaible in current version")}function r(e){var t=e.getSource();if(t){t.setStartDate(e.getParameter("date"+
));t.setSelectedView(t.getViews()[3])}}var a={__esModule:true};a.selectedAppointment=t;a.zoomIn=n;a.zoomOut=o;a.moreLinkHandler=r;return a});                                                                                                                  
//# sourceMappingURL=PlanningCalendarHandler.js.map                                                                                                                                                                                                            