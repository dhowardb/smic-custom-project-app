import ExtensionAPI from 'sap/fe/core/ExtensionAPI';
import MessageToast from 'sap/m/MessageToast';
import ResponsivePopover from 'sap/m/ResponsivePopover';
import SinglePlanningCalendar from 'sap/m/SinglePlanningCalendar';
import UI5Event from 'sap/ui/base/Event';
import Context from 'sap/ui/model/odata/v4/Context';
import CalendarAppointment from 'sap/ui/unified/CalendarAppointment';

export async function selectedAppointment(
	this: ExtensionAPI,
	event: UI5Event,
	pageContext: Context
): Promise<void> {
	const appointmentSelected = event.getParameter(
		'appointment'
	) as CalendarAppointment;

	const UIElements = this.loadFragment({
		name: 'projectsdemoappv2.projectsdemoappv2.ext.fragment.PlanningCalendar.views.CalendarDetails',
		controller: this,
		id: '',
		contextPath: '',
		initialBindingContext: pageContext,
	});

	UIElements.then(function (UIElement) {
		let appointmentBindingContext: Context;

		if (!appointmentSelected) {
			MessageToast.show('Appointment selected is not booked or blank!');
			return;
		}

		appointmentBindingContext =
			appointmentSelected.getBindingContext() as Context;

		const responsivePopOver = UIElement as unknown as ResponsivePopover;
		responsivePopOver
			.setBindingContext(appointmentBindingContext)
			.openBy(appointmentSelected);
	});
}

export function zoomIn(this: ExtensionAPI, event: UI5Event): void {
	// const view = (this.editFlow as any).getView() as View;
	// const SPCbuttonID = view.byId(event.getParameter('id'));
	// const SPCHeader = SPCbuttonID.getParent();
	// const SPC = SPCHeader.getParent() as SinglePlanningCalendar;

	// const appointments = SPC.getAppointments();
	MessageToast.show('Zoom in not yet avalaible in current version');
}

export function zoomOut(this: ExtensionAPI, event: UI5Event): void {
	MessageToast.show('Zoom out not yet avalaible in current version');
}

export function moreLinkHandler(this: ExtensionAPI, event: UI5Event): void {
	const SPC = event.getSource() as SinglePlanningCalendar;

	if (SPC) {
		SPC.setStartDate(event.getParameter('date'));
		SPC.setSelectedView(SPC.getViews()[3]);
	}
}
