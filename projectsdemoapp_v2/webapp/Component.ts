import BaseComponent from 'sap/fe/core/AppComponent';

/**
 * @namespace projectsdemoappv2.projectsdemoappv2
 */
export default class Component extends BaseComponent {
	public static metadata = {
		manifest: 'json',
	};

	/**
	 * The component is initialized by UI5 automatically during the startup of the app and calls the init method once.
	 * @public
	 * @override
	 */
	//public init() : void {
	//    super.init();
	//}
	public init(): void {
		// call the base component's init function
		super.init();

		// enable routing
		this.getRouter().initialize();
	}
}
