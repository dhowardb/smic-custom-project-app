sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'projectsdemoappv2.projectsdemoappv2',
            componentId: 'ProjectsObjectPage',
            entitySet: 'Projects'
        },
        CustomPageDefinitions
    );
});