# Speech-Enhancement
Implementation of a speech recognition algorithm, used to translate words into sign language by displaying images of hands forming the word after it has been pronounced. Produced on Matlab.

L’enjeu de ce projet est d’étudier différentes méthodes de débruitage d’un signal de parole. 
Pour procéder à ces études, un bruit connu est appliqué au signal, de manière à pouvoir comparer la qualité des résultats
en faisant varier certains paramètres. Ces différents résultats, qui seront détaillés tout au long de l’étude,
nous ont permis de choisir des paramètres de défaut.
Pour étudier les différents signaux bruités, nous appliquons au signal deux types de perturbations. Dans un premier cas,
nous ajoutons un bruit coloré, dont l’expression contient une sinusoïde. Nous utilisons l’expression cos(2πf0t) pour le
caractériser. Seule la fréquence f0 sera alors perturbée. Dans l’autre cas, nous ajoutons un bruit blanc gaussien
de variance choisie, correspondant à une variable aléatoire, qui perturbe l’ensemble de la bande fréquentielle.
Ce bruit est communément appelé neige.
Le but de notre étude est également de faire varier les paramètres caractérisant ces bruits, nous avons donc 
créé une fonction bruitage (visible en annexe), permettant à l’utilisateur de bruiter le signal en choisissant le
caractère blanc ou coloré du bruit, la valeur du Rapport Signal sur Bruit (RSB), la variance de la perturbation
dans un cas et la fréquence à perturber dans l’autre.
