functor
import
   ProjectLib
   Browser
   OS
   System
   Application
   OurOwnFunction at './Export.ozf'
   Open
define
   CWD = {Atom.toString {OS.getCWD}}#"/"
   Browse = proc {$ Buf} {Browser.browse Buf} end
   Print = proc{$ S} {System.print S} end
   Args = {Application.getArgs record('nogui'(single type:bool default:false optional:true)
				      'db'(single type:string default:CWD#"database.txt")
				      'ans'(single type:string default:CWD#"test_answers.txt" ))}
   
   BuildTreeDecision = OurOwnFunction.treeBuilder
   ForCreatingQuestionList = OurOwnFunction.createQuestionListFunc
   ForCreatingCharNameList = OurOwnFunction.createCharNameListFunc
   StdOutFile = {New Open.file init(name: stdout flags: [write create truncate text])}%This variable was taken from 'write_example.oz' file.
  		
in 
   local
      NoGUI = Args.'nogui'
      DB = Args.'db'
      Ans = Args.'ans'
      ListOfCharacters = {ProjectLib.loadDatabase file DB}
      NewCharacter = {ProjectLib.loadCharacter file CWD#"new_character.txt"}

      ListOfAnswers = {ProjectLib.loadCharacter file Ans}
      ListOfCharactersName = {ForCreatingCharNameList ListOfCharacters}
      ListOfQuestionsOnly  = {ForCreatingQuestionList {Arity ListOfCharacters.1} 0}
      PrintTheName = proc {$ N F}  {F write(vs:N)} end
     
      fun {TreeBuilder Database}
	 if Database == nil then nil
	 else
	    {BuildTreeDecision ListOfQuestionsOnly ListOfCharactersName Database}
	 end
      end

      
      proc {PrintManyNames L F}
      %The code below was taken from 'write_example.oz' file. 
	 case L
	 of H|nil then
	    {F write(vs:H#",")}
	 []H|T then
	    {F write(vs:H#",")}
	    {PrintManyNames T F}
	 end
      end
      
      fun {GameDriverAux TreeOnly}
	 case TreeOnly
	 of nil then false
	    
	 []leaf(H|T) then
	    {ProjectLib.found (H|T)}

	 []question(Q true:T false:F) then

	    if {ProjectLib.askQuestion Q} then
	       {GameDriverAux T}

	    else
	       {GameDriverAux F}
	    end
	 end
      end
      fun {GameDriver Tree}
	 Result
      in
	 Result = {GameDriverAux Tree}
	 
	 if Result == false then
            % Arf ! L'algorithme s'est trompé !
	    {Print 'Je me suis trompé\n'}
	    {Print {ProjectLib.surrender}}

            % warning, Browse do not work in noGUI mode
	    {Browse {ProjectLib.askQuestion 'A-t-il des cheveux roux ?'}}

	 else
	    if {List.is Result} then
	       {PrintManyNames Result StdOutFile}
	    else
	       {PrintTheName Result StdOutFile}
	      
	    end
	 end
	 
         % Toujours renvoyer unit
	 unit
      end
   in
      {ProjectLib.play opts(characters:ListOfCharacters
			    driver:GameDriver 
			    noGUI:NoGUI
			    builder:TreeBuilder 
			    autoPlay:ListOfAnswers
			    newCharacter:NewCharacter)}
      
      {StdOutFile close}
      {Application.exit 0}
   end
end