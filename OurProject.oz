declare
X = [character('Russell Lambert'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Katharine Singleton'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Braydon Bond'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Joely Dejesus'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Shaun Tyler'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Darnell Whittaker'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Osian Gough'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Elle Salter'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Tymon Rossi'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Junior Johns'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Phoenix Bonilla'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Arif Singh'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)]

 

TempList = {Arity X.1}
%----------------------------------------------------------------------------------------------------------
fun {CreateCharacterList DB}
   case DB
   of nil then nil
   []H|T then
      H.1|{CreateCharacterList T}
   end
end

 

fun {CreateQuestionList DB Acc}
   case DB
   of nil then nil
   []H|T then
      if Acc>0 then
     H|{CreateQuestionList T Acc+1}
      else
     {CreateQuestionList T Acc+1}
      end
   end
end

 

ListOfCharacters= {CreateCharacterList X} %List of all characters that are in DB
ListOfQuestions = {CreateQuestionList TempList 0} %List of all questions that are in DB
%----------------------------------------------------------------------------------------------------------

 

fun {DBIteration Q DB Acc}
   case DB
   of nil then Acc
   [] H1|T1 then
      if H1.Q == true then
     {DBIteration Q T1 Acc+1}
      else 
     {DBIteration Q T1 Acc-1}
      end
   end
end
%----------------------------------------------------------------------------------------------------------
fun {Abs X}
   if X < 0 then X * ~1
   else X
   end
end

 

%----------------------------------------------------------------------------------------------------------
fun {ListOfCountingTF L DB Acc}
   case L
   of nil then nil
   [] H|T then
      question(H acc: {DBIteration H DB Acc})|{ListOfCountingTF T DB 0} 
   end
end

 

%QuestionWithItsCount = {ListOfCountingTF ListOfQuestions X 0}  %Liste des toutes les questions avec leurs Acc(Cette variable calculer la difference en T et F pour chaque question)
%----------------------------------------------------------------------------------------------------------
fun {IsPartOfTheList Character L}
   case L
   of nil then false
   []H|T then
      if Character==H then
     true
      else
     {IsPartOfTheList Character T}
      end
   end
end
%----------------------------------------------------------------------------------------------------------
%L = List of characters
fun {ForTrueOrFalseListCharacter Q L DB Var} 
   case DB
   of nil then nil
   []H|T then
      if {IsPartOfTheList H.1 L} andthen H.Q == Var then
     H.1|{ForTrueOrFalseListCharacter Q L T Var}
      else
     {ForTrueOrFalseListCharacter Q L T Var}
      end
   end
end
%----------------------------------------------------------------------------------------------------------
%Cette fonction retourne la nouvelle liste des questions sans la question posée.
%L est une liste des questions
%V est une question déjà posée
fun {RemoveQ L V}
   case L
   of nil then nil
   []H|T then
      if H == V then {RemoveQ T V}
      else
     H|{RemoveQ T V}
 
      end
   end
end
%----------------------------------------------------------------------------------------------------------
%Cette fonction retourne la question optimale à posée
fun {OptimalQ L Min Question}
   case L 
   of nil then Question
   [] H|T then 
      if {Abs H.acc} =< Min then 
     {OptimalQ T H.acc H.1}
      else 
     {OptimalQ T Min Question}
      end
   end
end
%----------------------------------------------------------------------------------------------------------
%L1 = La liste des questions
%L2 = La liste des perso
%DB = La base  des données
%<DecisionTree>::= leaf(<List[Atom]>) | question(<Atom> true:<DecisionTree> false:<DecisionTree>)
 % (On update la liste des questions avec leurs Acc) --Done
 % (On crée la liste des persos pour True ) --Done
 % (On crée la liste des persos pour False) --Done
fun {BuildTree L1 L2 DB }
   if L1 == nil then leaf(L2)
   else
      local Q NewList T F in
	 Q = {OptimalQ {ListOfCountingTF L1 DB 0} 1000 nil}  % (On prend la question la plus optimale) --Done
	 NewList = {RemoveQ L1 Q} % (On enleve la question dans la liste des questions) --Done

	 T = {ForTrueOrFalseListCharacter Q L2 DB true}  % (On crée la liste des persos pour True ) --Done
	 F = {ForTrueOrFalseListCharacter Q L2 DB false} % (On crée la liste des persos pour False) --Done
       
        
	 question(Q true:{BuildTree NewList T DB} false:{BuildTree NewList F DB})
      end
   end   
end

 


fun {BuildDecisionTree DB}
   if DB == nil then nil
   else
      {BuildTree ListOfQuestions ListOfCharacters X}
   end
end

 

{Browse {BuildDecisionTree X}}