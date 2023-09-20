## Application Details

|                                                                                             |
| ------------------------------------------------------------------------------------------- |
| **Generation Date and Time**<br>Mon Sep 18 2023 10:13:21 GMT+0800 (Singapore Standard Time) |
| **App Generator**<br>@sap/generator-fiori-elements                                          |
| **App Generator Version**<br>1.10.2                                                         |
| **Generation Platform**<br>Visual Studio Code                                               |
| **Template Used**<br>List Report Page V4                                                    |
| **Service Type**<br>OData Url                                                               |

|**Service URL**<br>https://smphckapd4s.sm.ph:44300/sap/opu/odata4/sap/zui_demo_s4_project_int_o4/srvd/sap/zui_demo_s4_project_interface/0001/
|**Module Name**<br>projectsdemoapp_v2|
|**Application Title**<br>SMIC Projects v2|
|**Namespace**<br>projectsdemoapp_v2|
|**UI5 Theme**<br>sap_fiori_3|
|**UI5 Version**<br>1.96.0|
|**Enable Code Assist Libraries**<br>False|
|**Enable TypeScript**<br>True|
|**Add Eslint configuration**<br>False|
|**Main Entity**<br>Projects|
|**Navigation Entity**<br>\_Objects|

## projectsdemoapp_v2

SMIC Projects v2

### Starting the generated app

- This app has been generated using the SAP Fiori tools - App Generator, as part of the SAP Fiori tools suite. In order to launch the generated app, simply run the following from the generated app root folder:

```
    npm start
```

- It is also possible to run the application using mock data that reflects the OData Service URL supplied during application generation. In order to run the application with Mock Data, run the following from the generated app root folder:

```
    npm run start-mock
```

#### Pre-requisites:

1. Active NodeJS LTS (Long Term Support) version and associated supported NPM version. (See https://nodejs.org)

## Development Added

### Excel Upload Handler

- Create handler for excel upload using external modules(XLSX and ui5spreadsheetimporter from SAPUI5)

```
    npm install ui5-cc-spreadsheetimporter
```

- Create excel upload handler in TS source code under controller\ExcelUploadHandler
- use yo ui5-spreadsheetimporter or perform manual steps in manifest.json(
  "resourceRoots": {
  "cc.spreadsheetimporter.v0_25_3": "./thirdparty/customControl/spreadsheetImporter/v0_25_3"
  },
  "componentUsages": {
  "spreadsheetImporter": {
  "name": "cc.spreadsheetimporter.v0_25_3"
  }
  })
- extend app using fiori flexible programming model(FPM) by adding custom action
- add on package.json "build" to include third party controls

```
    --all
```
