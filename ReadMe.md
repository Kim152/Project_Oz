-> Ouvre le terminal dans le dossier du projet

-> Compile le fichier des fonction :
	ozc -c ExportFunc.oz -o Export.ozf  (Si tout va bien, le terminal va rien imprimer)
	
-> Compile le fichier principal :
	ozc -c Example.oz -o Example.ozf
	
Attention: Dans ce cas ci, le terminal va renvoyer des Warnings mais stresse pas haha.
	    Regarde si sur la dernière ligne du message il y a le mot "Accepted" => Tout va bien
	    Sinon tu auras "Rejected" => Il y a une erreur quelque part. 
	    
-> Si ç'a bien marché, tu peux run ce code: 
	ozengine Example.ozf

Que le jeu commence :)
