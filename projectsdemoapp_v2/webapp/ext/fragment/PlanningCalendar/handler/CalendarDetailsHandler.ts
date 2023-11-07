import ExtensionAPI from 'sap/fe/core/ExtensionAPI';
import Button from 'sap/m/Button';
import Popover from 'sap/m/Popover';
import UI5Element from 'sap/ui/core/Element';
import UI5Event from 'sap/ui/base/Event';
import Dialog from 'sap/m/Dialog';
import MessageToast from 'sap/m/MessageToast';
import Context from 'sap/ui/model/odata/v4/Context';
import Form from 'sap/ui/layout/form/Form';

export function handleEditPopOver(
	this: ExtensionAPI,
	event: UI5Event,
	pageContext: Context
): void {
	const source = event.getSource() as Button;
	const footer = source.getParent() as UI5Element;
	const popOver = footer.getParent() as Popover;

	if (popOver.isOpen()) {
		popOver.close();

		const currentBindingContext = popOver.getBindingContext() as Context;
		const UIElements = this.loadFragment({
			name: 'projectsdemoappv2.projectsdemoappv2.ext.fragment.PlanningCalendar.views.CalendarModify',
			controller: this,
			id: '',
			contextPath: '',
			// initialBindingContext: pageContext,
			initialBindingContext: currentBindingContext,
		});

		UIElements.then(function (UIElement) {
			const formDialog = UIElement as unknown as Dialog;
			formDialog.open();
			// formDialog.setBindingContext(currentBindingContext).open();
		});
	}
}

// export function handleCancelPopOver(
// 	this: ExtensionAPI,
// 	event: UI5Event,
// 	pageContext: Context
// ): void {
// 	const source = event.getSource() as Button;
// 	const footer = source.getParent() as UI5Element;
// 	const popOver = footer.getParent() as Popover;

// 	if (popOver.isOpen()) {
// 		popOver.close();
// 	}
// }

export async function handleDeleteProject(
	this: ExtensionAPI,
	event: UI5Event,
	pageContext: Context
) {
	const responsivePopOver = (
		(event.getSource() as Button).getParent() as UI5Element
	).getParent() as Popover;
	const currentBindingContext =
		responsivePopOver.getBindingContext() as Context;

	await currentBindingContext.delete().then(function () {
		MessageToast.show('Project Succesfully Deleted!');
	});
}
