import ExtensionAPI from 'sap/fe/core/ExtensionAPI';
import UI5Event from 'sap/ui/base/Event';
import MessageToast from 'sap/m/MessageToast';
import ODataListBinding from 'sap/ui/model/odata/v4/ODataListBinding';
import EditFlow from 'sap/fe/core/controllerextensions/EditFlow';
import View from 'sap/ui/core/mvc/View';
import JSONModel from 'sap/ui/model/json/JSONModel';
import Context from 'sap/ui/model/odata/v4/Context';
import Model from 'sap/ui/model/Model';
import FeedListItem from 'sap/m/FeedListItem';

/**
 * Generated event handler.
 *
 * @param this reference to the 'this' that the event handler is bound to.
 * @param event the event object provided by the event provider
 */
export function onPress(this: ExtensionAPI, event: UI5Event) {
	// MessageToast.show('Customer invoked action');
}

interface stateMode {
	display: string;
	editable: string;
}

interface selectFeedListParameters {
	sId: string;
}
export async function onPost(this: ExtensionAPI, event: UI5Event) {
	if (!isEditingAllowed(this.getModel('ui'))) {
		MessageToast.show('Cannot post any content in Display Mode');
		return;
	}

	const editFlow = this.editFlow as EditFlow;
	const view = (editFlow as any).getView() as View;

	const getEvent = event.getSource();
	const id = event.getMetadata();
	const feedList = view.byId(
		'projectsdemoappv2.projectsdemoappv2::ProjectsObjectPage--fe::CustomSubSection::FeedContent--feedsList'
	);
	const commentFeedEntity = {
		Content: event.getParameter('value'),
	};
	const feedListsBindingItems = feedList.getBinding(
		'items'
	) as ODataListBinding;
	feedListsBindingItems.create(commentFeedEntity);
}

export function onPressDelete(this: ExtensionAPI, event: UI5Event) {
	if (!isEditingAllowed(this.getModel('ui'))) {
		MessageToast.show('Cannot delete any content in Display Mode');
		return;
	}
	const editFlow = this.editFlow as EditFlow;
	const view = (editFlow as any).getView() as View;

	const parameters = event.getParameter('item') as selectFeedListParameters;
	// eslint-disable-next-line fiori-custom/sap-no-ui5base-prop
	const feedListID = parameters.sId;

	const lineItemForAction = view.byId(feedListID);
	const lineItemContext = lineItemForAction.getBindingContext() as Context;
	lineItemContext.delete();
}

export function onPressEdit(this: ExtensionAPI, event: UI5Event) {
	if (!isEditingAllowed(this.getModel('ui'))) {
		MessageToast.show('Cannot edit any content in Display Mode');
		return;
	}
	MessageToast.show('Updating...');
	const editFlow = this.editFlow as EditFlow;
	const view = (editFlow as any).getView() as View;

	const parameters = event.getParameter('item') as selectFeedListParameters;
	// eslint-disable-next-line fiori-custom/sap-no-ui5base-prop
	const feedListID = parameters.sId;

	const lineItemForAction = view.byId(feedListID) as FeedListItem;
	const lineItemContext = lineItemForAction.getBindingContext() as Context;
	const lineItemBinding = lineItemContext.getBinding() as ODataListBinding;

	const commentFeedEntity = {
		Content: event.getParameter('value'),
	};
}

export function isEditingAllowed(uiModel: Model | never) {
	if (!uiModel) {
		return false; //or throw error
	}
	const isEditable = (uiModel as Model).bindList('/isEditable');
	const isEditableModel = isEditable.getModel();
	const isEditableDatas = (isEditableModel as JSONModel).getData();

	const editMode: string = isEditableDatas.editMode;
	const editObjects = { display: 'Display', editable: 'Editable' } as stateMode;
	if (editMode === editObjects.display) {
		return false;
	} else {
		return true;
	}
}
