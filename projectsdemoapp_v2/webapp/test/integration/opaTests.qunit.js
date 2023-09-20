sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'projectsdemoappv2/projectsdemoappv2/test/integration/FirstJourney',
		'projectsdemoappv2/projectsdemoappv2/test/integration/pages/ProjectsList',
		'projectsdemoappv2/projectsdemoappv2/test/integration/pages/ProjectsObjectPage',
		'projectsdemoappv2/projectsdemoappv2/test/integration/pages/ObjectsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProjectsList, ProjectsObjectPage, ObjectsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('projectsdemoappv2/projectsdemoappv2') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProjectsList: ProjectsList,
					onTheProjectsObjectPage: ProjectsObjectPage,
					onTheObjectsObjectPage: ObjectsObjectPage
                }
            },
            opaJourney.run
        );
    }
);