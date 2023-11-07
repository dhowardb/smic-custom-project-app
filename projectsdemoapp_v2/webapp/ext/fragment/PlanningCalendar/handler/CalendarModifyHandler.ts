import ExtensionAPI from 'sap/fe/core/ExtensionAPI';
import Button from 'sap/m/Button';
import DatePicker from 'sap/m/DatePicker';
import Dialog from 'sap/m/Dialog';
import Label from 'sap/m/Label';
import MessageToast from 'sap/m/MessageToast';
import UI5Event from 'sap/ui/base/Event';
import Field from 'sap/ui/comp/smartmultiedit/Field';
import UI5Element from 'sap/ui/core/Element';
import Form from 'sap/ui/layout/form/Form';
import Context from 'sap/ui/model/odata/v4/Context';
import ODataModel from 'sap/ui/model/odata/v4/ODataModel';
import View from 'sap/ui/vk/View';

export function handleDialogCancel(this: ExtensionAPI, event: UI5Event) {
	const dialog = (event.getSource() as Button).getParent() as Dialog;
	if (dialog.isOpen()) {
		dialog.close();
	}
	const view = (this.editFlow as any).getView() as View;
	const model = view.getModel() as ODataModel;
	model.resetChanges();
}

export const handleDialogUpdate = (event: UI5Event) => {
	MessageToast.show('Update Button was clicked! Posting...');
	const dialog = (event.getSource() as Button).getParent() as Dialog;
	const bindingContext = dialog.getBindingContext() as Context;
	bindingContext.refresh();
	if (bindingContext.hasPendingChanges()) {
		MessageToast.show('has pending Changes');
	}

	const form = dialog.getAggregation('content') as Form;
	// form.
};

export const handleDialogDelete = (event: UI5Event) => {
	MessageToast.show('Delete Button was clicked! Deleting...');
};

export function handleDatePickerChange(
	this: ExtensionAPI,
	event: UI5Event,
	pageContext: Context
) {
	const source = event.getSource() as DatePicker;
	const label = source.getParent() as Label;

	const formElements = label
		.getParent()
		.getAggregation('formElements') as UI5Element[];

	const startDate = (
		(formElements[1] as UI5Element).getAggregation('fields') as Field[]
	)
		.reduce((field) => field)
		.getValue() as Date;

	const endDate = (
		(formElements[2] as UI5Element).getAggregation('fields') as Field[]
	)
		.reduce((field) => field)
		.getValue() as Date;

	const form = label.getParent().getParent() as Form;
	const dialog = form.getParent().getParent().getParent() as Dialog;
	const updateButton = dialog.getAggregation('beginButton') as Button;

	if (endDate < startDate) {
		if (updateButton.getEnabled()) {
			updateButton.setEnabled(false);
		}
		MessageToast.show('Cannot update! Start Date should be before End Date ');
		return;
	}
	updateButton.setEnabled(true);
	const view = (this.editFlow as any).getView() as View;
	const model = view.getModel() as ODataModel;
	const hasPendingChanges = model.hasPendingChanges();
	const updateGroupID = model.getUpdateGroupId();

	if (hasPendingChanges) {
		// model.resetChanges();
	}
	// model.refresh();
}

export const handleModelContextChange = (event: UI5Event) => {
	const source = event.getSource();
	const parameters = event.getParameters();
};
