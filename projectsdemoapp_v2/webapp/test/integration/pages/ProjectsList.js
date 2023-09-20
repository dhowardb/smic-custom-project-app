sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'projectsdemoappv2.projectsdemoappv2',
            componentId: 'ProjectsList',
            entitySet: 'Projects'
        },
        CustomPageDefinitions
    );
});