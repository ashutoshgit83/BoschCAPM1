sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'po/bosch/managepo/test/integration/FirstJourney',
		'po/bosch/managepo/test/integration/pages/poworklistSetList',
		'po/bosch/managepo/test/integration/pages/poworklistSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, poworklistSetList, poworklistSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('po/bosch/managepo') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThepoworklistSetList: poworklistSetList,
					onThepoworklistSetObjectPage: poworklistSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);