/*
 * IP_LQG_PCI6221_2015a_Integrator_data.c
 *
 * Code generation for model "IP_LQG_PCI6221_2015a_Integrator".
 *
 * Model version              : 1.33
 * Simulink Coder version : 8.8 (R2015a) 09-Feb-2015
 * C source code generated on : Fri Mar 21 16:35:20 2025
 *
 * Target selection: rtwin.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86/Pentium
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "IP_LQG_PCI6221_2015a_Integrator.h"
#include "IP_LQG_PCI6221_2015a_Integrator_private.h"

/* Block parameters (auto storage) */
P_IP_LQG_PCI6221_2015a_Integrator_T IP_LQG_PCI6221_2015a_Integrator_P = {
  /*  Variable: A
   * Referenced by: '<Root>/LQG'
   */
  { 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, -0.017404859575843416, 0.0,
    -0.017375920561817897, -232.02520137511431, 0.0, 0.0, 20.786124708700459,
    0.0, 63.831866309774568, 0.0, 0.0, 0.0, -0.0023164464704312983, 1.0,
    -0.0071135482677263393, 0.0, 0.0, 0.0, 57.534432075073113, 0.0,
    57.438769726892971, -755.4249991873927, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
  1.5707963267948966,                  /* Variable: ALPHA_MAX
                                        * Referenced by:
                                        *   '<S4>/Lower Limit'
                                        *   '<S4>/Upper Limit'
                                        */
  0.26179938779914941,                 /* Variable: BETA_MAX
                                        * Referenced by:
                                        *   '<S2>/Lower Limit'
                                        *   '<S2>/Upper Limit'
                                        */

  /*  Variable: K
   * Referenced by: '<Root>/LQG'
   */
  { -10.005103168757866, -5.8012563544382338, 57.783262337127539,
    7.2082574306026466, 0.10386654845159463, -0.010000000000022418 },

  /*  Variable: L
   * Referenced by: '<Root>/LQG'
   */
  { 3.2289965918181918, 0.98324644752720747, 1.1385177435020331,
    8.08815299126025, -0.29941992429136877, 0.49381297351583858,
    1.1385177435020331, 11.872137157596315, 14.278404311361685, 97.5861112279773,
    -3.6108042070521718, 0.056303862951421556, 0.49381297351583858,
    0.047993186991182948, 0.056303862951421556, 0.41215027908884772,
    -0.014609009813550771, 3.2772861591926734 },
  6.0,                                 /* Variable: TIME_DELAY
                                        * Referenced by: '<S1>/Time delay'
                                        */
  5.0,                                 /* Variable: V_MAX
                                        * Referenced by: '<S1>/Motor protection'
                                        */
  -5.0,                                /* Variable: V_MIN
                                        * Referenced by: '<S1>/Motor protection'
                                        */
  0.0,                                 /* Mask Parameter: AnalogOutput_FinalValue
                                        * Referenced by: '<S1>/Analog Output'
                                        */
  0.0,                                 /* Mask Parameter: AnalogOutput_InitialValue
                                        * Referenced by: '<S1>/Analog Output'
                                        */
  0.0,                                 /* Mask Parameter: EncoderInput1_InputFilter
                                        * Referenced by: '<S3>/Encoder Input1'
                                        */
  0.0,                                 /* Mask Parameter: EncoderInput_InputFilter
                                        * Referenced by: '<S5>/Encoder Input'
                                        */
  0.0,                                 /* Mask Parameter: EncoderInput1_MaxMissedTicks
                                        * Referenced by: '<S3>/Encoder Input1'
                                        */
  0.0,                                 /* Mask Parameter: EncoderInput_MaxMissedTicks
                                        * Referenced by: '<S5>/Encoder Input'
                                        */
  10.0,                                /* Mask Parameter: AnalogOutput_MaxMissedTicks
                                        * Referenced by: '<S1>/Analog Output'
                                        */
  0.0,                                 /* Mask Parameter: EncoderInput1_YieldWhenWaiting
                                        * Referenced by: '<S3>/Encoder Input1'
                                        */
  0.0,                                 /* Mask Parameter: EncoderInput_YieldWhenWaiting
                                        * Referenced by: '<S5>/Encoder Input'
                                        */
  0.0,                                 /* Mask Parameter: AnalogOutput_YieldWhenWaiting
                                        * Referenced by: '<S1>/Analog Output'
                                        */
  0,                                   /* Mask Parameter: EncoderInput1_Channels
                                        * Referenced by: '<S3>/Encoder Input1'
                                        */
  1,                                   /* Mask Parameter: EncoderInput_Channels
                                        * Referenced by: '<S5>/Encoder Input'
                                        */
  0,                                   /* Mask Parameter: AnalogOutput_Channels
                                        * Referenced by: '<S1>/Analog Output'
                                        */
  0,                                   /* Mask Parameter: AnalogOutput_RangeMode
                                        * Referenced by: '<S1>/Analog Output'
                                        */
  0,                                   /* Mask Parameter: AnalogOutput_VoltRange
                                        * Referenced by: '<S1>/Analog Output'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/LQG'
                                        */
  6.2831853071795862,                  /* Expression: 2*pi
                                        * Referenced by: '<S6>/Angle'
                                        */
  4096.0,                              /* Expression: 4096
                                        * Referenced by: '<S6>/Encoder resolution'
                                        */
  6.2831853071795862,                  /* Expression: 2*pi
                                        * Referenced by: '<S5>/Angle'
                                        */
  4096.0,                              /* Expression: 4096
                                        * Referenced by: '<S5>/Encoder resolution'
                                        */
  3.1415926535897931,                  /* Expression: pi
                                        * Referenced by: '<S5>/Bias'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S1>/Time delay'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S1>/Time delay'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S1>/Const motor'
                                        */
  3.0,                                 /* Expression: 3
                                        * Referenced by: '<S1>/Motor switch'
                                        */
  -1.0,                                /* Expression: -1
                                        * Referenced by: '<S1>/Gain'
                                        */

  /*  Expression: [0 0]
   * Referenced by: '<S1>/Const sensors'
   */
  { 0.0, 0.0 },
  3.0,                                 /* Expression: 3
                                        * Referenced by: '<S1>/Sensors switch'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Integrator'
                                        */
  10.0                                 /* Expression: 10.0
                                        * Referenced by: '<Root>/Gain'
                                        */
};

/* Constant parameters (auto storage) */
const ConstP_IP_LQG_PCI6221_2015a_Integrator_T
  IP_LQG_PCI6221_2015a_Integrator_ConstP = {
  /* Expression: A-B*K-L*C
   * Referenced by: '<Root>/LQG'
   */
  { 0.0, 0.0, 0.0, 0.0, -3335.0685549757368, 0.0, 0.0, 0.0, 0.0, 0.0,
    -1933.771928255102, 0.0, 0.0, 0.0, 0.0, 0.0, 19261.284763782496, 0.0, 0.0,
    0.0, 0.0, 0.0, 2402.7770915987121, 0.0, 0.0, 0.0, 0.0, 0.0,
    34.622537500308738, 0.0, 0.0, 0.0, 0.0, 0.0, -3.3333674813043053, 0.0 },

  /* Expression: A-B*K-L*C
   * Referenced by: '<Root>/LQG'
   */
  { 3.2289965918181918, 0.98324644752720747, 1.1385177435020331,
    8.08815299126025, -0.29941992429136877, 0.49381297351583858, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 1.1385177435020331, 11.872137157596315, 14.278404311361685,
    97.5861112279773, -3.6108042070521718, 0.056303862951421556, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.49381297351583858,
    0.047993186991182948, 0.056303862951421556, 0.41215027908884772,
    -0.014609009813550771, 3.2772861591926734 }
};
