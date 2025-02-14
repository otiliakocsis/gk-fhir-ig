//============== ALIAS ===============

//====== Profiles =====================================

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  ResearchSubjectGK
Parent:   ResearchSubject
Id:       researchSubject-gk
Title:    "ResearchSubject (Gatekeeper)"
Description: "This profile defines how to represent in FHIR the subject enrollment in the pilots for supporting the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------
* identifier MS
* status MS
* period MS 
* study	MS // check is is enough a business identifier..
* individual MS

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  RiskAssessmentGK
Parent:   RiskAssessment
Id:       riskAssessment-gk
Title:    "RiskAssessment (Gatekeeper)"
Description: "This profile defines how to represent a PREDICTION OF EXACERBATIONS FOR PEOPLE WITH COPD, HEART FAILURE OR POLYMEDICATED PEOPLE by using FHIR RiskAssessment for supporting the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------
* status MS
* code 1.. MS // type of code
* subject MS
* occurrence[x] only dateTime
* occurrenceDateTime 1.. MS
* basis MS
* prediction.probability[x] 1.. MS
* note MS


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  CareTeamGK
Parent:   CareTeam
Id:       careTeam-gk
Title:    "CareTeam (Gatekeeper)"
Description: "This profile defines how to represent a Care Team in FHIR for supporting the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------
* status MS
* subject 1.. MS
* subject only Reference(PatientGK)
* participant 1.. MS
* participant.role MS
* participant.member 1.. MS
* reasonCode MS
* managingOrganization	MS


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  TaskMkGK
Parent:   Task
Id:       task-mk-gk
Title:    "Task - Milton Keynes (Gatekeeper)"
Description: "This profile defines how to represent a task in FHIR for supporting the Milton Keynes pilot in the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------
* identifier MS
* basedOn only Reference(ServiceRequestMkGK)
* status MS
* intent MS
// * for only Reference(Patient) // check if this is enough
* for only Reference(PatientGK) // check if this is enough
* executionPeriod MS
* owner MS
* output MS


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  ServiceRequestMkGK
Parent:   ServiceRequest
Id:       serviceRequest-mk-gk
Title:    "ServiceRequest - Milton Keynes (Gatekeeper)"
Description: "This profile defines how to represent a service request in FHIR for supporting the Milton Keynes pilot in the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------
* identifier MS
// * instantiatesCanonical only canonical(ActivityDefinition) //clarify how to restrict canonical to ActivityDefinition
* instantiatesCanonical MS
* status MS
* subject MS
* requester MS
* performer MS
* locationCode	0.. // Σ	0..*	CodeableConcept	Requested location
* locationReference	0.. // Σ	0..*	Reference(Location)	Requested location
* reasonCode	0.. // Σ	0..*	CodeableConcept	Explanation/Justification for procedure or service Procedure Reason Codes (Example)
* reasonReference 0.. //
* supportingInfo 0.. MS
* supportingInfo ^slicing.discriminator[0].type = #type
* supportingInfo ^slicing.discriminator[0].path = "$this.resolve()"
* supportingInfo ^slicing.ordered = false
* supportingInfo ^slicing.rules = #open
* supportingInfo ^short = "Components composing the supporting information"
* supportingInfo ^definition = "The root of the components that make up the supporting information slice."
* supportingInfo contains   risk 0..* 
* supportingInfo[risk] ^short = "Probability of increasing severity over time if the intervention is not implemented."
* supportingInfo[risk] ^definition = "Probability of increasing severity over time if the intervention is not implemented. The risk function is used to update the cumulative level of risk for the target of the intervention and it is inherited by the target of the intervention." 
* supportingInfo[risk] only Reference(RiskAssessment)


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  ConditionGK
Parent:   $Condition-uv-ips
Id:       Condition-gk
Title:    "Condition (Gatekeeper)"
Description: "This profile defines how to represent patient conditions in FHIR for the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------
* code from VsConditionGK (extensible)


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  ObservationFloorClimbed
Parent:   Observation 
Id:       Observation-floorClimbed-gk
Title:    "Observation Floor Climbed (Gatekeeper)"
Description: "This profile defines how to represent the number of Floor Climbed in FHIR for the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------

* status 1..1	MS // code	registered | preliminary | final | amended +
* code	1..1 MS
* code	= CsGatekeeper#floor-climbed // "Floors climbed"
* subject	0..1 MS
* device 0.. MS
* device only Reference(Device)
* effective[x]	MS
* valueQuantity 1.. MS


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  ObservationExercisePanel
Parent:   Observation 
Id:       Observation-exercisePanel-gk
Title:    "Observation Exercise tracking panel (Gatekeeper)"
Description: "This profile defines how to represent Exercise tracking panel observations in FHIR for the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------

* status 1..1	MS // code	registered | preliminary | final | amended +
* code	1..1 MS
* code	= $loinc#55409-7	// Exercise tracking panel
* subject	0..1 MS
* device 0.. MS
* device only Reference(Device)
// * subject only Reference (PatientGK) //	Who and/or what the observation is about
* effective[x]	MS

* component 1.. MS
* component ^slicing.discriminator[0].type = #pattern
* component ^slicing.discriminator[0].path = "code"
* component ^slicing.ordered = false
* component ^slicing.rules = #open
* component ^short = "Components composing the Exercise tracking panel"
* component ^definition = "The root of the components that make up the the Exercise tracking panel observation."
* component contains   activityType 0..1 
	and aerobicCategory 0..1
	and caloriesBurned 0..1
	and exerciseDuration 0..1
	and exerciseDistance 0..1
	and heartRateMax 0..1

* component[activityType] ^short = "Exercise activity"
* component[aerobicCategory] ^short = "Exercise aerobic category"			
* component[caloriesBurned] ^short = "Calories burned Machine estimate"
* component[exerciseDuration] ^short = "Exercise duration"
* component[exerciseDistance] ^short = "Exercise distance unspecified time"
* component[heartRateMax] ^short = "Heart rate Encounter maximum"

* component[activityType].code  = $loinc#73985-4	 // Exercise activity
* component[aerobicCategory].code =  $loinc#73986-2	// Exercise aerobic category
* component[caloriesBurned].code = $loinc#55421-2	// Calories burned Machine estimate			kcal
* component[exerciseDuration].code = $loinc#55411-3	// Exercise duration			min
* component[exerciseDistance].code = $loinc#55412-1	// Exercise distance unspecified time			[mi_us];km
* component[heartRateMax].code = $loinc#55422-0	// Heart rate Encounter maximum			{beats}/min
	
* component[activityType].code MS
* component[aerobicCategory].code MS
* component[caloriesBurned].code MS 
* component[exerciseDuration].code MS
* component[exerciseDistance].code MS
* component[heartRateMax].code MS
	
* component[activityType].valueCodeableConcept 1.. MS
* component[activityType].valueCodeableConcept from http://loinc.org/vs/LL734-5 (example)
* component[aerobicCategory].valueCodeableConcept 1.. MS 
* component[aerobicCategory].valueCodeableConcept from http://loinc.org/vs/LL2555-2 (example)
* component[caloriesBurned].valueQuantity 1.. MS 
* component[caloriesBurned].valueQuantity.value 1.. MS
* component[caloriesBurned].valueQuantity.unit 0.. MS
* component[caloriesBurned].valueQuantity.system = "http://unitsofmeasure.org"
* component[caloriesBurned].valueQuantity.code = #kcal
* component[exerciseDuration].valueQuantity 1.. MS 
* component[exerciseDuration].valueQuantity.value 1.. MS
* component[exerciseDuration].valueQuantity.unit 0.. MS
* component[exerciseDuration].valueQuantity.system = "http://unitsofmeasure.org"
* component[exerciseDuration].valueQuantity.code = #min

* component[exerciseDistance].valueQuantity 1.. MS 
* component[exerciseDistance].valueQuantity.value 1.. MS
* component[exerciseDistance].valueQuantity.unit 0.. MS
* component[exerciseDistance].valueQuantity.system = "http://unitsofmeasure.org"
* component[exerciseDistance].valueQuantity.code = #km

* component[heartRateMax].valueQuantity 1.. MS 
* component[heartRateMax].valueQuantity.value 1.. MS
* component[heartRateMax].valueQuantity.unit 0.. MS
* component[heartRateMax].valueQuantity.system = "http://unitsofmeasure.org"
* component[heartRateMax].valueQuantity.code = #{beats}/min
	
/* ===	
 Indent73985-4	Exercise activity			
 Indent73986-2	Exercise aerobic category			
 Indent55421-2	Calories burned Machine estimate			kcal
 Indent55411-3	Exercise duration			min
 Indent55412-1	Exercise distance unspecified time			[mi_us];km
 Indent55422-0	Heart rate Encounter maximum			{beats}/min
=== */

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  ObservationGK
Parent:   Observation 
Id:       Observation-gk
Title:    "Observation (Gatekeeper)"
Description: "This profile defines how to represent observations in FHIR for the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------

* status 1..1	MS // code	registered | preliminary | final | amended +
* code	1..1 MS
* code	from VsObservationGK (extensible)
* subject	0..1 MS
// * subject only PatientGK //	Who and/or what the observation is about
* effective[x]	MS




//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  LabResultGK
Parent:   $Observation-results-laboratory-uv-ips
Id:       Observation-labResult-gk
Title:    "Laboratory results (Gatekeeper)"
Description: "This profile defines how to represent laboratory results performed by an authorized loboratory in FHIR using a standard LOINC code and UCUM units of measure. It is based on the Laboratory IPS profile"

//-------------------------------------------------------------------------------------------
* code from VsLabTestGK (extensible)


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  EncounterGK
Parent:   Encounter
Id:       Encounter-gk
Title:    "Encounter (Gatekeeper - Aragon)"
Description: "This profile defines how to represent Encounter in the Aragon Pilot."
// from Aragon Pilot
//-------------------------------------------------------------------------------------------

* subject MS // participant_id String The unique identifier of the patient.
// Date of record TO BE ADDED
* period.start MS // Date of admission
* period.end MS // Date of discharge
* reasonCode MS // Main reason for admission add binding ICD-10
* type MS // Admission planned / unplanned / missing 
* hospitalization.admitSource MS // Place of residence before admission 1 - Home          2 - Nursing home       4 - Other         999 - Missing answer TO BE CHECKED
* hospitalization.dischargeDisposition MS // Place of residence after admission 1 - Home          2 - Nursing home  3 - Death         4 - Other         999 - Missing answer



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  QuestionnaireResponseAragonGK
Parent:   QuestionnaireResponse
Id:       QuestionnaireResponse-ar-gk
Title:    "QuestionnaireResponse (Gatekeeper - Aragon)"
Description: "This profile defines how to represent QuestionnaireResponse responses in the Aragon Pilot."
// from Aragon Pilot
//-------------------------------------------------------------------------------------------

* identifier MS // record_id	YES	Numeric	20	Identification of the record that contains all the answers to the same questionnaire 
* questionnaire MS // questionnaire_id	YES	String	20	Identification of the questionnaire
* subject MS
* subject only Reference(PatientGK) // participant_id	YES	String	20	The unique identifier of the patient.
* authored MS // completion_date	YES	Date		Date of record
* item.linkId MS  // question_id	YES	Numeric	20	Identification of the number of the question to which the answer corresponds to
* item.answer.value[x] only string or Quantity	// answer	YES	Numeric	String	Answer to the question in the specific questionnaire




//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  MedicationRequestGK
Parent:   MedicationRequest
Id:       MedicationRequest-gk
Title:    "MedicationRequest (Gatekeeper)"
Description: "This profile defines how to represent MedicationRequest (Prescribed Medicines) in FHIR in Gatekeeper."
// from Aragon Pilot
//-------------------------------------------------------------------------------------------

* status MS // 0 – Inactive 1- Active
* medicationCodeableConcept MS // ATC coding 
* subject MS
* subject only Reference(PatientGK) // The unique identifier of the patient.	N.A
* authoredOn MS // Date of record	dd/mm/yyyy
* dosageInstruction.timing.repeat.boundsPeriod.start  MS // start date of treatment	NA
* dosageInstruction.timing.repeat.boundsPeriod.end MS // 00/00/0000 if end_date is not defined	NA
* dosageInstruction.timing.code.text 0..1 // sequence Moments of day for medicine intake	String indicating moments of day in which medicine should be taken 
* dosageInstruction.text MS // calendar Weekdays to apply sequence	String with weekdays in Spanish in which medicine should be taken
* dosageInstruction.doseAndRate.doseQuantity MS // Dose Value of the dose to be taken	and // Unit Code of measurement	E.g. mg -> miligram


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Profile:  AppointmentGK
Parent:   Appointment
Id:       Appointment-gk
Title:    "Appointment (Gatekeeper)"
Description: "This profile defines how to represent Appointments in FHIR in Gatekeeper."
// from GR - CY Pilot
//-------------------------------------------------------------------------------------------
* identifier MS // ID	YES	Numeric	20	The unique identifier of the Appointment	N.A
// Meta [version, last updated]	YES	Numeric and Date/Time	25	Defines the type of the appointment	N.A.
* status MS // YES	Code 	10	Status of the appointment	Options: proposed | pending | booked |
* appointmentType	MS // 	YES	CodeableConcept	10	Type of the appointment 	Options: physical, virtual/video, chat
* start	MS // YES	Date / Time	10	When appointment is to take place	Instant
* end MS // YES	Date / Time	10	When appointment is to conclude	Instant
* slot MS // YES	Reference(Slot) https://www.hl7.org/fhir/slot.html	10	The slots that this appointment is filling	Slot 
* created MS // YES	dateTime	20	The date that this appointment was initially created	dateTime
* participant.actor MS //
* participant.status MS //  [actor/status] 	YES	Reference to patient id / Code		Participants involved in appointment and their role	Patient IDs and HCPs IDs


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  CarePlanGK
Parent:   CarePlan
Id:       CarePlan-gk
Title:    "CarePlan (Gatekeeper)"
Description: "This profile defines how to represent CarePlans in FHIR in Gatekeeper."
// from GR - CY Pilot
//-------------------------------------------------------------------------------------------
* identifier MS
* status MS // [ active | on-hold | revoked | completed]
* category	MS // 	http://snomed.info/sct which codes ?
* subject only Reference(PatientGK) // YES	Reference to patient id	50	Who the care plan is for	Patient IDs
* subject MS // YES	Reference to patient id	50	Who the care plan is for	Patient IDs
* period MS //	YES	Date/Time	20	Time period plan covers	N.A.
* author MS // YES	Reference to Practitioner ID	20	Who is the designated responsible party	Practitioner IDs
* careTeam MS // 	YES	Reference to CareTeam	50	Who's involved in plan?	N/A
* goal.display MS 
* activity MS //	YES	Reference to activity types [Activity List: Medication / Nutrition / Education / Laboratory Exams / Exercise / Questionnaires / Observation] 	10	Action to occur as part of plan	Activity List - LOINC


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  PractitionerGK
Parent:   $Practitioner-uv-ips
Id:       Practitioner-gk
Title:    "Practitioner (Gatekeeper)"
Description: "This profile defines how to represent Practitioners in FHIR in Gatekeeper."
//-------------------------------------------------------------------------------------------


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  VitalSignGK
Parent:   $vitalsigns
Id:       Observation-vitalsigns-gk
Title:    "Vital Signs (Gatekeeper)"
Description: "This profile defines how to represent Vital Signs observations in FHIR using a standard LOINC code and UCUM units of measure."

//-------------------------------------------------------------------------------------------
* code from VsVitalSignsGK (extensible)

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  BodyTempGK
Parent:   $bodytemp
Id:       Observation-bodytemp-gk
Title:    "Body Temperature (Gatekeeper)"
Description: "This profile defines how to represent Body Temperature observations in FHIR using a standard LOINC code and UCUM units of measure."

//-------------------------------------------------------------------------------------------


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  OxygenSatGK
Parent:   $oxygensat
Id:       Observation-oxygensat-gk
Title:    "Oxygen Saturation (Gatekeeper)"
Description: "This profile defines how to represent Oxygen Saturation Profile observations in FHIR using a standard LOINC code and UCUM units of measure."

//-------------------------------------------------------------------------------------------


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  BloodPressureGK
Parent:   $bp
Id:       Observation-bp-gk
Title:    "Blood Pressure (Gatekeeper)"
Description: "This profile defines how to represent Blood Pressure Profile observations in FHIR using a standard LOINC code and UCUM units of measure."

//-------------------------------------------------------------------------------------------


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  HeartRateGK
Parent:   $heartrate
Id:       Observation-hr-gk
Title:    "Heart Rate (Gatekeeper)"
Description: "This profile defines how to represent Heart Rate Profile observations in FHIR using a standard LOINC code and UCUM units of measure."

//-------------------------------------------------------------------------------------------

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  RadResultGK
Parent:   $Observation-results-radiology-uv-ips
Id:       Observation-radResult-gk
Title:    "Radiology results (Gatekeeper)"
Description: "This profile defines how to represent radiology results in FHIR. It is based on the Radiology IPS profile"

//-------------------------------------------------------------------------------------------

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  PathResultGK
Parent:   $Observation-results-pathology-uv-ips
Id:       Observation-pathResult-gk
Title:    "Pathology results (Gatekeeper)"
Description: "This profile defines how to represent pathology results in FHIR. It is based on the Pathology IPS profile"

//-------------------------------------------------------------------------------------------


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  LabSelfTestGK
Parent:   $Observation-results-uv-ips
Id:       Observation-labSelfTest-gk
Title:    "Laboratory self test results (Gatekeeper)"
Description: "This profile defines how to represent self test results in FHIR for the scope of Gatekeeper. using a standard LOINC code and UCUM units of measure."

//-------------------------------------------------------------------------------------------
// * subject only $Patient-uv-ips
* code from VsLabSelfTestGK (extensible)
* value[x] only Quantity
* value[x] 1..1 MS
* hasMember 0..0



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  BloodGlucoseGK
Parent:	  ObservationGK // use Observation until the constraiunt on timing will no be removed
Id:       Observation-bloodGlucose-gk
Title:    "Blood Glucose Moles/volume (Gatekeeper)"
Description: "This profile defines how to represent Blood Glucose Profile observations in FHIR using a standard LOINC code and UCUM units of measure."

//-------------------------------------------------------------------------------------------
// * subject only $Patient-uv-ips
* category MS
* code MS
* code = $loinc#15074-8 // "Glucose [Moles/volume] in Blood"
* subject 1.. MS
* effective[x] 1.. MS
* effective[x].extension ..1 MS
* effective[x].extension only $data-absent-reason
* effective[x].extension ^short = "effective[x] absence reason"
* effective[x].extension ^definition = "Provides a reason why the effectiveTime is missing."
* performer only Reference(PractitionerUvIps or PractitionerRoleUvIps or OrganizationUvIps or CareTeam or PatientUvIps or RelatedPerson)
* performer MS
* value[x] MS
* value[x] only Quantity
* value[x] 1..1 MS
* hasMember 0..0


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  ObservationSocialGK
Parent:   ObservationGK 
Id:       Observation-social-gk
Title:    "Observation Social Assessment(Gatekeeper)"
Description: "This profile defines how to represent social observations (living status; tobacco use;..) for the scope of the Gatekeeper project"
//-------------------------------------------------------------------------------------------
* subject 1..1 MS
* code	from VsSocialObservationGK (extensible)

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> COMMENTED TO BE RECOVERED IF SPECILAZED LAB RESULTS ARE REALLY NEEDED 

Profile:  FastingPlasmaGlucoseGK
Parent:   $Observation-results-uv-ips
Id:       Observation-fpg-gk
Title:    "Fasting plasma glucose (Gatekeeper)"
Description: "This profile defines how to represent Fasting plasma glucose observations in FHIR using a standard LOINC code and UCUM units of measure."
//-------------------------------------------------------------------------------------------
// * subject only $Patient-uv-ips
* code from VsFastingPlasmaGlucoseGK
* value[x] only Quantity
* value[x] 1..1 MS
* hasMember 0..0
=== */

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  StepsNumberGK
Parent:   $Observation-results-uv-ips
Id:       Observation-stepsNumber-gk
Title:    "Steps Number(Gatekeeper)"
Description: "This profile defines how to represent Number of Steps measures Observation in FHIR using a standard LOINC code and UCUM units of measure."
//-------------------------------------------------------------------------------------------
// * subject only $Patient-uv-ips
* code from VsStepsGK
* value[x] only Quantity
* value[x] 1..1 MS
* hasMember 0..0

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  SleepDurationGK
Parent:   $Observation-results-uv-ips
Id:       Observation-sleepDuration-gk
Title:    "Sleep Duration (Gatekeeper)"
Description: "This profile defines how to represent Sleep Duration Observation in FHIR using a standard LOINC code and UCUM units of measure."
//-------------------------------------------------------------------------------------------
// * subject only $Patient-uv-ips
* code from VsSleepDurationGK
* value[x] only Quantity
* value[x] 1..1 MS
* hasMember 0..0