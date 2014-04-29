ThesisStatsProject
==================
 
 Ensemble de scripts permettant de générer un certain nombre de statistiques sur les thèses en France ainsi que des fichiers à importer dans Gephi et qui représentent :
 - le réseau des codirections de thèse
 - le réseau des disciplines
 
Les scripts sont à utiliser dans cet ordre.

ThesisCrawlerShort.R
--------------------

Récupère automatiquement toutes les données mises à disposition par theses.fr.
Il faut juste spécifier le dossier où sera enregistré le fichier de sortie.

Pour tous les fichiers suivants il faudra spécifier le dossier d'entrée et de sortie, ainsi que le nom du fichier d'entrée et de sortie.

SimpleStats.R
-------------
Propose quelques statistiques sur les titres de thèses. Optionnel pour la suite.

AdvancedStats.R
---------------
Propose des statistiques un peu plus exigeantes sur les codirections. Optionnel pour la suite.

DirLinkMaker.R
--------------
Génère la liste de liens nécessaires pour représenter le réseau des codirections de thèses dans Gephi.

DisLinkMaker.R
--------------
Génère la liste de liens nécessaires pour représenter le réseau disciplinaire des thèses dans Gephi.
On considère deux disciplines comme voisines dans le graphe si un même directeur a dirigé une thèse dans chacune de ces deux disciplines.

Normalizer.R
------------
Normalise les noms (de disciplines typiquement) et génère la liste des noeuds (de disciplines) pour le graphe.

Tous ces scripts ont été testés sous Ubuntu 13.10 avec R 3.0.1. et Rstudio 0.98.501. Je ne donne absolument aucune garantie pour d'autres versions.
