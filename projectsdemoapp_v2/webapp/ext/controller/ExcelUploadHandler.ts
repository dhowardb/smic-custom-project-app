import ExtensionAPI from 'sap/fe/core/ExtensionAPI';
import Context from 'sap/ui/model/odata/v4/Context';
import EditFlow from 'sap/fe/core/controllerextensions/EditFlow';
import View from 'sap/ui/core/mvc/View';
import BaseController from 'sap/fe/core/BaseController';
import Component, {
	Component$ChangeBeforeCreateEvent,
	Component$CheckBeforeReadEvent,
	Component$UploadButtonPressEvent,
} from 'cc/spreadsheetimporter/v0_25_3/Component';

/**
 * Generated event handler.
 *
 * @param this reference to the 'this' that the event handler is bound to.
 * @param pageContext the context of the page on which the event was fired
 */
export async function ExcelUploadFunction(
	this: ExtensionAPI,
	pageContext: Context
) {
	const editFlow = this.editFlow as EditFlow;
	const view = (editFlow as any).getView() as View;
	const controller = view.getController() as BaseController;

	view.setBusyIndicatorDelay(0);
	view.setBusy(true);

	const spreadSheetUpload = (await controller
		.getAppComponent()
		.createComponent({
			usage: 'spreadsheetImporter',
			async: true,
			componentData: {
				context: this,
				activateDraft: true,
				columns: [
					'ProjectName',
					'StartDate',
					'CompletionDate',
					'ProjectedDate',
				],
				mandatoryFields: ['ProjectName'],
			},
		})) as Component;

	// event to check before uploaded to app
	spreadSheetUpload.attachCheckBeforeRead(function (
		event: Component$CheckBeforeReadEvent
	) {
		//CheckBeforeReadEvent delete upon adding code
	},
	this);

	// event example to prevent uploading data to backend
	spreadSheetUpload.attachUploadButtonPress(function (
		event: Component$UploadButtonPressEvent
	) {
		//UploadButtonPressEvent delete upon adding code
	},
	this);

	// event to change data before send to backend
	spreadSheetUpload.attachChangeBeforeCreate(function (
		event: Component$ChangeBeforeCreateEvent
	) {
		//ChangeBEforeCreateEvent delete upon adding code
	},
	this);
	spreadSheetUpload.openSpreadsheetUploadDialog('');
	view.setBusy(false);
}
