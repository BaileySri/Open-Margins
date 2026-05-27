# Open Margins

## Abstract

Cyber-physical systems have been the center of proactive defense research against sensor spoofing, in which an adversary gains implicit control of a system’s actuation by injecting false signals. Software-only defenses have been a popular approach for addressing sensor spoofing in resource constrained deployments. In particular, physics-based attack detection (PBAD), in which a software model of expected behavior is updated and checked for anomalous deviations with observed behavior, has seen significant attention. The widespread popularity of PBAD has led to a cat-and-mouse game between increasingly subtle attacks and evermore complex models. In this work, we seek to analyze PBAD abstractly to determine if there is a logical end-point to the effectiveness of the technique. We find that the key factor in the effectiveness of the technique is the precision of the sensors themselves, rather than the model, and show thresholds of precision that are not only sufficient to detect sensor attacks but necessary to make any such guarantees. An important outcome of our analysis is the relevance of the attack-noise ratio, a metric that both provides comparative results for evaluations and a guideline for selecting sensors of a CPS for PBAD guarantees. In this work we develop a general model for single sensor PBAD, using a finite impulse response filter, and statistically analyze the model to define relationships between parameters and detector performance. Concretely, we define limits of a PBAD model as a function of detector and attack parameters and statistically show that PBAD deployments can be made effective through high-fidelity sensor hardware.

## Structure

``` text
Git Repository
│   README.md
│
│   AttackTerms.m           Symbolically generate only the attack term from equation 4
│   ErrorTerms.m            Symbolically generate only the error terms from equation 4
│   Expression.m            Symbolically generate the result of expanding equation 4
│
│   HeuristicGraphs.m       Generates distributions of equation 4 with convolution
│   BulkParamEvaluator.m    Wrapper function for HeuristicGraphs, generates TPR for bulk parameters
│   MyPlot.m                Helper function, generates base plot before editing for paper
│   ThresholdFinder.m       Helper function, Calculates threshold to meet false positive rate
│   AreaAbove.m             Helper function, outputs right-tail AUC
│
│	FigX.m					All of the FigX.m scripts generate the corresponding Fig X in the paper
│   ExampleSensor.m			Generates the TPR graph corresponding to the example in Section 4.3.3
│
└───Figures
    └───Image files generated from scripts used in the paper 
```

## Example enumerating Equation 4 for a window size of 5

``` MATLAB
Expression(5)
```

Output:

``` MATLAB
(w^4 - 3*w^3 + 3*w^2 - w)*e1 + (- w^3 + 2*w^2 - w)*e2 + (w^2 - w)*e3 + (-w)*e4 + e5 + (w^4 - 5*w^3 + 10*w^2 - 10*w + 5)*a
```