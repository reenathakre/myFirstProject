/***********************************************************************************
* ComponentName: CheckUniqueSurvey
* CreatedBy: Rojalin Parida
* LastModifiedBy: Rojalin Parida
* LastModifiedOn: 02/07/2017
* Description: To check the unquieness of survey 
--------------------------------------------------------
* Revision History

* ---------------------------------------*/


Trigger CheckUniqueSurvey on Survey__c (Before Insert, Before Update) {

   List<String> uniqueValueList = new List<String>();
    for(Survey__c sv : Trigger.new){
        uniqueValueList.add(sv.SurveyName__c + string.valueOF(sv.StartDate__c)+ string.valueOF(sv.EndDate__c));
    }
    
    
    List<Survey__c > svList = [select id, name, CheckDuplicate__c from Survey__c ];
    
    Map<String,Survey__c > uniqueValueMap = new Map<String,Survey__c >();
    for(Survey__c  sv : svList){
        uniqueValueMap.put(sv.CheckDuplicate__c,sv);        
    }
    
    
    for(Survey__c   a : Trigger.new){
        if(uniqueValueMap.containsKey(a.SurveyName__c + string.valueOF(a.StartDate__c)+ string.valueOF(a.EndDate__c))){
             if((a.id<>uniqueValueMap.get(a.SurveyName__c + string.valueOF(a.StartDate__c)+ string.valueOF(a.EndDate__c)).id))
             {
                a.addError('An Survey matching this criteria already exists');
            }           
        }
    }

   }