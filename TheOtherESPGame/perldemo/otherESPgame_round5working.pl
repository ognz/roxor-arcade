#!/usr/bin/perl

#With thanks to http://nedbatchelder.com/text/hexwords.html for the hex words
#With thanks to http://www.network-science.de/ascii/ for the ascii artification of words


#The following is a brief description of what is done in each round
#Round 1: 6 stack values, esp always at the bottom, ebp always at the top
#Round 2: 6 stack values, esp & ebp random locations, but same stack orientation
#Round 3: Same as previous, but now whether the low addresses are on top or bottom of diagram is randomized
#Round 4: 8 stack values, added horizontal diagrams, so now low addresses can be top, bottom, left, or right
#Round 5: Make it so that randomly you will only have the choice to offset from one of esp or ebp
#Round 6: Add in the notion of parameters passed in on the stack as well as function return address and saved ebp

use Switch;
use Time::Local;

@wordList = ("acce55", "acc01ade", "affab1e", "a1fa1fa", "a5be5705", "babb1e", "badd00d", "ba1dd00d", "ba77d00d", "ba11ad", "ba5eba11", "bead", "beef", "be5077ed", "b1ade", "b1e55ed", "b100d", "b0bb1e", "b0b51ed", "b01dface", "b00b", "b007ab1e", "b055", "cabba1a", "cab1e", "cafebabe", "ca11ab1e", "ca5cade", "ca55e77e", "cede", "c0a1e5ce", "c0bb1e", "c0de", "c01055a1", "dabb1e", "dad", "deadbeef", "debac1e", "deba7e", "decade", "decaf", "decea5ed", "dec0de", "deface", "defea7", "de1e7ed", "d00dad", "d00d1e", "ea7ab1e",, "ee1", "effab1e", "effec7ed", "e1de57", "e1ec7ed", "e1f", "e5ca1ade", "fab1ed", "face1e55", "face7ed", "fad", "faded", "fa11", "feca1", "fece5", "feeb1e", "f1ea", "f1ee", "f1eece", "f100ded", "f0ca1", "f01ded", "f00d", "f005ba11", "f007ba11", "1abe1", "1ac7a5e", "1ad1e", "1ead", "1eaf", "10ca1e", "1005e", "0af", "0b501e7e", "0b57ac1e", "0ddba11", "0ffbea7", "0ff5e7", "00d1e5", "5add1ed", "5a1ad", "5caff01d", "5c0ff", "5eaf00d", "5e1ec7", "50f7ba11", "501ace", "57abbed", "7ab1e", "7ac71e55", "7a7700", "7e1eca57", "7e117a1e", "70ad5", "70bacc0", "70cca7a", "7001", "707a1ed"); 

srand();

my $currentScore = 0;

print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "Welcome to the perl demo of The Other ESP Game!\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "In this game of skill, you will learn to represent data\n";
print "values on \"the stack\" (as used in x86 assembly) as \n";
print "relative to either the stack pointer, the \"esp\" register,\n";
print "or the stack frame base pointer, \"ebp\".\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "ROUND 1: 1000 points needed to pass\n";
print "Hit any key to continue\n";
chomp($userInput = <STDIN>);

#Round 1 will always have 6 possible stack values, with the ebp at the top and the esp at the bottom

#while($currentScore < 1000){
	$numStackElements = 6;
	$indexToFind = int(rand($numStackElements));
	$ebpIndex = $numStackElements-1;
	$espIndex = 0;
	$numSeconds = localtime();
	$orientation = 0;
	$correctness = StackPrint($orientation, $numStackElements, $ebpIndex, $espIndex, $indexToFind, 0, 6);
	ScoreKeeper($correctness, 100, 9999);
#}

print '  ___   _    _  _    _  _    _  __   __ _____  ___   _   _  _  _  _ '; print "\n";
print ' / _ \ | |  | || |  | || |  | | \ \ / /|  ___|/ _ \ | | | || || || |'; print "\n";
print '/ /_\ \| |  | || |  | || |  | |  \ V / | |__ / /_\ \| |_| || || || |'; print "\n";
print '|  _  || |/\| || |/\| || |/\| |   \ /  |  __||  _  ||  _  || || || |'; print "\n";
print '| | | |\  /\  /\  /\  /\  /\  /   | |  | |___| | | || | | ||_||_||_|'; print "\n";
print '\_| |_/ \/  \/  \/  \/  \/  \/    \_/  \____/\_| |_/\_| |_/(_)(_)(_)'; print "\n";

print "~~~~~~~~~~~~~~~~~~~~~~LEVEL 1 COMPLETED~~~~~~~~~~~~~~~~~~~~~~\n";
print "In this round, ebp and esp will not always be at the top and \n";
print "bottom of the stack fragment you are shown. You will also \n";
print "have a time bonus in this and subsequent rounds where you \n";
print "will get 50% bonus for answering in 1 or less seconds, 40%\n";
print "for answering in 1-2 seconds, etc, until no bonus for \n";
print "answering in 5 or more seconds.\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "ROUND 2: 3000 points needed to pass\n";
print "Hit any key to continue\n";
chomp($userInput = <STDIN>);

#while($currentScore < 3000){
	$numStackElements = 6;
	$indexToFind = int(rand($numStackElements));
	print "indexToFind = $indexToFind\n";
	$ebpIndex = $numStackElements/2 + int(rand($numStackElements/2)); #want this to stay on the bottom half of the stack for now
	print "ebpIndex = $ebpIndex\n";
	$espIndex = int(rand($numStackElements/2)); #want this to stay on the top half of the stack for now
	print "espIndex = $espIndex\n";
	$timeBonus = timelocal(localtime());
	$orientation = 0;
	$correctness = StackPrint($orientation, $numStackElements, $ebpIndex, $espIndex, $indexToFind, 0, 6);
	$timeBonus = timelocal(localtime()) - $timeBonus;
	print "timeBonus = $timeBonus\n";
	ScoreKeeper($correctness, 200, $timeBonus);
#}

print '    ____   ____   ______ __ __    ____   _   __ __ __ __'; print "\n";
print '   / __ \ / __ \ / ____// //_/   / __ \ / | / // // // /'; print "\n";
print '  / /_/ // / / // /    / ,<     / / / //  |/ // // // / '; print "\n";
print ' / _, _// /_/ // /___ / /| |   / /_/ // /|  //_//_//_/  '; print "\n";
print '/_/ |_| \____/ \____//_/ |_|   \____//_/ |_/(_)(_)(_)   '; print "\n";

print "~~~~~~~~~~~~~~~~~~~~~~LEVEL 2 COMPLETED~~~~~~~~~~~~~~~~~~~~~~\n";
print "It's very important to pick a stack frame layout that works \n";
print "for you, and stick with it. The preceeding layout of low \n";
print "addresses low and high addresses high was picked because that \n";
print "is how the stack is represented in the book \n";
print "\"Computer Systems: A Programmer's Perspective\" which is \n";
print "used in computer science architecture classes.\n";
print "\n";
print "The thing is...not everyone is going to use the same layout\n";
print "as you. Some people like the stack to grow upward, like a\n";
print "stack of flapjacks! You need to stay mentally flexible, so\n";
print "you should practice with other peoples' orientations too.\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "ROUND 3: 5000 points needed to pass\n";
print "Hit any key to continue\n";
chomp($userInput = <STDIN>);

#while($currentScore < 5000){
	$numStackElements = 6;
	$indexToFind = int(rand($numStackElements));
#	print "indexToFind = $indexToFind\n";
	$ebpIndex = $numStackElements/2 + int(rand($numStackElements/2)); #want this to stay on the bottom half of the stack for now
#	print "ebpIndex = $ebpIndex\n";
	$espIndex = int(rand($numStackElements/2)); #want this to stay on the top half of the stack for now
#	print "espIndex = $espIndex\n";
	$timeBonus = timelocal(localtime());
	$orientation = int(rand(2));
	$correctness = StackPrint($orientation, $numStackElements, $ebpIndex, $espIndex, $indexToFind, 0, 6);
	$timeBonus = timelocal(localtime()) - $timeBonus;
#	print "timeBonus = $timeBonus\n";
	ScoreKeeper($correctness, 200, $timeBonus);
#}

print '  ___    __    _  _    _  _  _____  __  __ ';print "\n";
print ' / __)  /__\  ( \( )  ( \/ )(  _  )(  )(  )';print "\n";
print '( (__  /(__)\  )  (    \  /  )(_)(  )(__)( ';print "\n";
print ' \___)(__)(__)(_)\_)   (__) (_____)(______)';print "\n";
print ' '; print "\n";
print ' ____  ____  ___    ____  ____  ___ /\\';print "\n";
print '(  _ \(_  _)/ __)  (_  _)(_  _)(__ ))(';print "\n";
print ' )(_) )_)(_( (_-.   _)(_   )(   (_/ \/';print "\n";
print '(____/(____)\___/  (____) (__)  (_) ()';print "\n";

print "~~~~~~~~~~~~~~~~~~~~~~LEVEL 3 COMPLETED~~~~~~~~~~~~~~~~~~~~~~\n";
print "Remember \"Smashing the Stack for Fun and Profit\"? Of course\n";
print "you do. Wait, what? You don't. Oh, well then you should go\n";
print "read it AFTER you're done with this game ;). Funny thing is\n";
print "in that paper aleph1 represented the stack as growing both\n";
print "upward, but also to the left! (With the memory writes to\n";
print "overflow the buffer going toward the left, in typical English\n";
print "fashion. Anyway, now we're going to mix it up so that the\n";
print "stack can grow up, down, left, or right! :D\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "ROUND 4: 9000 points needed to pass\n";
print "Hit any key to continue\n";
chomp($userInput = <STDIN>);

#while($currentScore < 9000){
	$numStackElements = 8;
	$indexToFind = int(rand($numStackElements));
	$ebpIndex = $numStackElements/2 + int(rand($numStackElements/2)); #want this to stay on the bottom half of the stack for now
	$espIndex = int(rand($numStackElements/2)); #want this to stay on the top half of the stack for now
	$timeBonus = timelocal(localtime());
	$orientation = int(rand(4));
	$correctness = StackPrint($orientation, $numStackElements, $ebpIndex, $espIndex, $indexToFind, 0, 6);
	$timeBonus = timelocal(localtime()) - $timeBonus;
	ScoreKeeper($correctness, 400, $timeBonus);
#}


print "Y   Y  OOO  U   U '' V     V EEEE     GGG   OOO  TTTTTT \n";
print " Y Y  O   O U   U '' V     V E       G     O   O   TT   \n";
print "  Y   O   O U   U     V   V  EEE     G  GG O   O   TT   \n";
print "  Y   O   O U   U      V V   E       G   G O   O   TT   \n";
print "  Y    OOO   UUU        V    EEEE     GGG   OOO    TT  \n";
print "\n";
print "TTTTTT H  H EEEE    TTTTTT  OOO  U   U  CCC H  H !!! !!! !!! \n";
print "  TT   H  H E         TT   O   O U   U C    H  H !!! !!! !!! \n";
print "  TT   HHHH EEE       TT   O   O U   U C    HHHH !!! !!! !!! \n";
print "  TT   H  H E         TT   O   O U   U C    H  H             \n";
print "  TT   H  H EEEE      TT    OOO   UUU   CCC H  H !!! !!! !!! \n";

print "~~~~~~~~~~~~~~~~~~~~~~LEVEL 4 COMPLETED~~~~~~~~~~~~~~~~~~~~~~\n";
print "So thus far, in order to go faster, maybe you have always\n";
print "been choosing to offset from only one of ebp or esp (with\n";
print "the occasional opportunistic switching it up if it's easier\n";
print "to go from the other one.) Now just to be mean, I'm going to\n";
print "make it so that occasionally you will try to pick an offset\n";
print "from ebp but the relavant displacement is not available, so\n";
print "you will have to instead go calculate from esp instead (or\n";
print "vice versa). Good luck getting a time bonus now...enjoy ;)\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "ROUND 5: 18000 points needed to pass\n";
print "Hit any key to continue\n";
chomp($userInput = <STDIN>);

while($currentScore < 18000){
	$numStackElements = 10;
	$indexToFind = int(rand($numStackElements));
	$ebpIndex = $numStackElements/2 + int(rand($numStackElements/2)); #want this to stay on the bottom half of the stack for now
	$espIndex = int(rand($numStackElements/2)); #want this to stay on the top half of the stack for now
	$timeBonus = timelocal(localtime());
	$orientation = int(rand(4));
	$oneOffsetOnly = int(rand(3));
	print "random oneOffsetOnly = $oneOffsetOnly\n";
	$correctness = StackPrint($orientation, $numStackElements, $ebpIndex, $espIndex, $indexToFind, $oneOffsetOnly, 6);
	$timeBonus = timelocal(localtime()) - $timeBonus;
	ScoreKeeper($correctness, 800, $timeBonus);
}

print"  _   _   _   _   _   _     _   _   _  \n";
print" / \ / \ / \ / \ / \ / \   / \ / \ / \ \n";
print"( K | I | C | K | I | N ) ( A | S | S )\n";
print" \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \n";
print"  _   _   _  \n";
print" / \ / \ / \ \n";
print"( A | N | D )\n";
print" \_/ \_/ \_/ \n";
print"  _   _   _   _   _     _   _   _   _   _   _   _   _  \n";
print" / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \ / \ / \ \n";
print"( T | A | K | I | N ) ( N | A | M | E | S | ! | ! | ! )\n";
print" \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \n";

#$orientation values: 0 = low addresses at bottom, 1 = low addresses at top, 2 = low addresses at left, 3 = low addresses at right
#$numStackElements, 1-based number of elements in the stack, so if == 1, then there will be 1 element which both ebp and esp point at
#$ebpIndex & espIndex: 0-based index from the lowest element.
#$indexToFind: 0-based index from the lowest element which should be entered by the user.
#$oneOffsetOnly:0 = should include ebp-relative AND esp-relative offset options
	#	1 = ebp-relative-only offset, esp-relative should be impossible to select
	#	2 = esp-relative-only offset, ebp-relative should be impossible to select
#$numOffsetChoices: the number of choices of offsets a user is given
sub StackPrint{
	$orientation = $_[0];
	$numStackElements = $_[1];
	$ebpIndex = $_[2];
	$espIndex = $_[3];
	$indexToFind = $_[4];
	$oneOffsetOnly = $_[5];
	$numOffsetChoices = $_[6];

	#Calculate the distance from both ebp and esp to the indexToFind
	$ebpRelToFind = $indexToFind - $ebpIndex;
#	print "ebpRelToFind = $ebpRelToFind\n";
	$espRelToFind = $indexToFind - $espIndex;
#	print "espRelToFind = $espRelToFind\n";

	#Calculate the given number of random choices to display for the user, and also the place where the correct choices will be displayed
	#ebp and esp can't pick the same index
	$ebpOffsetDisplayIndex = int(rand($numOffsetChoices));
#	print "ebpOffsetDisplayIndex = $ebpOffsetDisplayIndex\n";
	if($ebpRelToFind != $espRelToFind){
		do{
			$espOffsetDisplayIndex = int(rand($numOffsetChoices));
#			print "candidate espOffsetDisplayIndex = $espOffsetDisplayIndex\n";
		}while($espOffsetDisplayIndex == $ebpOffsetDisplayIndex);
#		print "espOffsetDisplayIndex = $espOffsetDisplayIndex\n";
	}

	#going to generate an array just storing the order in which the randomized options will be displayed
        @displayOrder = ();
        for($i = 0; $i < $numOffsetChoices; $i++){
                if($i == $ebpOffsetDisplayIndex){
			#If the mode is currently set for no ebp offset, skip this
			if($oneOffsetOnly != 2){
	#                       printf("i = %d, pushed ebpRelToFind = %d\n",$i, $ebpRelToFind);
	                        push(@displayOrder, $ebpRelToFind);
	                        next;
			}
                }
                if($espOffsetDisplayIndex != $ebpOffsetDisplayIndex && $i == $espOffsetDisplayIndex){
			#If the mode is currently set for no esp offset, skip this
			if($oneOffsetOnly != 1){
	#                       printf("i = %d, pushed espRelToFind = %d\n",$i, $espRelToFind);
	                        push(@displayOrder, $espRelToFind);
	                        next;
			}
                }
                $posOrNeg = int(rand(2));
                while(1){
                        #I'm doing the +2 just so it can have some values that are out of bounds
                        $randOffset = int(rand($numStackElements+2));
                        if($posOrNeg){
                                $randOffset = -$randOffset;
                        }
			if($oneOffsetonly == 0 && $ebpRelToFind == $randOffset || $espRelToFind == $randOffset) {next;}
			if($oneOffsetOnly == 1 && $ebpRelToFind == $randOffset) {next;}
			if($oneOffsetOnly == 2 && $espRelToFind == $randOffset) {next;}
#                       print "candidate randOffset = $randOffset\n";
			#check for duplicates, because I want all presented values to be unique
			for($j = 0; $j < $i; $j++){
#				print "j = $j, displayOrder[j] = $displayOrder[$j], randOffset = $randOffset\n";
				if($displayOrder[$j] == $randOffset) {goto nextWhile;}
			}
			#if we get here, that means the current chosen randOffset is not
			#equal to any of the previous ones
#	                print "accepted randOffset = $randOffset\n";
			last;
nextWhile:
			next;
		}
#               printf("i = %d, pushed randOffset = %d\n",$i, $randOffset);
                push(@displayOrder, $randOffset);
        }
#       print "displayOrder = @displayOrder\n";


	#convert the ebp and esp relative values into eventual number-letter combinations like the user will have to input
	
	@correctInput = ();
	$i = 0;
	if($oneOffsetOnly == 0 || $oneOffsetOnly == 1){
		@correctInput[$i] = "a$ebpOffsetDisplayIndex";
		$i++;
	}
	if($oneOffsetOnly == 0 || $oneOffsetOnly == 2){
		@correctInput[$i] = "b$espOffsetDisplayIndex";
	}
	print "correctInput = @correctInput\n";

	#now generate the random values to display on the stack
	@randStackStuff = ();
	for($i = 0; $i < $numStackElements; $i++){

		do{
			$randWord = $wordList[int(rand(@wordList))];
#			print "Candidate randWord = $randWord\n";
		}while(grep {$_ eq $randWord} @randStackStuff);
#		print "accepting $randWord\n";
		push(@randStackStuff, $randWord);
	}

	PrintStackWithOrientation($orientation, $ebpIndex, $espIndex, \@randStackStuff);

	print "Enter the combination of number and letter (like \"a1\", \"b4\", etc) for the offset to:\n";
	print "$randStackStuff[$indexToFind]\n";
	print "a) ebp, b) esp\n";
	for ($i = 0; $i < @displayOrder; $i++){
		$tmp = $displayOrder[$i]*4; #TODO: Change this 4 to 8 in the future for 64 bit version
		print "$i) $tmp\t";
	}
	print "\n";
	print "> ";

	chomp($userInput = <STDIN>);
	if($userInput eq $correctInput[0] || $userInput eq $correctInput[1]){
		return 1;
	}
	else{
		return 0;
	}
}

#$orientation values: 0 = low addresses at bottom, 1 = low addresses at top, 2 = low addresses at left, 3 = low addresses at right
sub PrintStackWithOrientation{
	$orientation = $_[0];
	$ebpIndex = $_[1];
	$espIndex = $_[2];
	$stackArrayRef = $_[3];
	@array = @{$stackArrayRef};

	switch($orientation){
		#low addresses at bottom
		case 0{
			print "\nHIGH ADDRESSES\n";
			for($i = @array-1; $i >= 0; $i--){
				print "|------------|\n";
				print "| 0x";
				if(length($array[$i]) > 8){
					print "length($array[$i])\n";
					return;
				}
				$padding = 8 - length($array[$i]);
				while($padding){
					print "0";
					$padding--;
				}
				print "$array[$i] |";

				if($i == $ebpIndex) {print " <-- ebp";}
				if($i == $espIndex) {print " <-- esp";}

				print "\n";
			}
			print "|------------|\n";
			print "LOW ADDRESSES\n\n";
		}
		#low addresses at top
		case 1{
				print "\nLOW ADDRESSES\n";
			for($i = 0; $i < @array; $i++){
				print "|------------|\n";
				print "| 0x";
				if(length($array[$i]) > 8){
					print "length($array[$i])\n";
					return;
				}
				$padding = 8 - length($array[$i]);
				while($padding){
					print "0";
					$padding--;
				}
				print "$array[$i] |";

				if($i == $ebpIndex) {print " <-- ebp";}
				if($i == $espIndex) {print " <-- esp";}

				print "\n";
			}
			print "|------------|\n";
			print "HIGH ADDRESSES\n\n";
		}
		#low addresses at left
		case 2{
			print "case 2\n";
			print "LOW ADDRESSES ";
			for($i = 0; $i < @array; $i++){
				print "|------------";
			}
			print "| HIGH ADDRESSES\n";

			print "LOW ADDRESSES ";
			for($i = 0; $i < @array; $i++){
				print "| 0x";
				if(length($array[$i]) > 8){
					print "length($array[$i])\n";
					return;
				}
				$padding = 8 - length($array[$i]);
				while($padding){
					print "0";
					$padding--;
				}
				print "$array[$i] ";

			}
			print "| HIGH ADDRESSES\n";

			print "LOW ADDRESSES ";
			for($i = 0; $i < @array; $i++){
				if($i == $ebpIndex || $i == $espIndex) {print "|^^^^^^^^^^^^";}
				else{print "|------------";}
			}
			print "| HIGH ADDRESSES\n";

			print "LOW ADDRESSES ";
			for($i = 0; $i < @array; $i++){
				if($i == $ebpIndex) {print "|     EBP    ";}
				elsif($i == $espIndex) {print "|     ESP    ";}
				else {print "|            ";}
			}
			print "| HIGH ADDRESSES\n";
		}
		#low addresses at right
		case 3{
			print "HIGH ADDRESSES ";
			for($i = @array-1; $i >= 0; $i--){
				print "|------------";
			}
			print "| LOW ADDRESSES\n";

			print "HIGH ADDRESSES ";
			for($i = @array-1; $i >= 0; $i--){
				print "| 0x";
				if(length($array[$i]) > 8){
					print "length($array[$i])\n";
					return;
				}
				$padding = 8 - length($array[$i]);
				while($padding){
					print "0";
					$padding--;
				}
				print "$array[$i] ";

			}
			print "| LOW ADDRESSES\n";

			print "HIGH ADDRESSES ";
			for($i = @array-1; $i >= 0; $i--){
				if($i == $ebpIndex || $i == $espIndex) {print "|^^^^^^^^^^^^";}
				else{print "|------------";}
			}
			print "| LOW ADDRESSES\n";

			print "HIGH ADDRESSES ";
			for($i = @array-1; $i >= 0; $i--){
				if($i == $ebpIndex) {print "|     EBP    ";}
				elsif($i == $espIndex) {print "|     ESP    ";}
				else {print "|            ";}
			}
			print "| LOW ADDRESSES\n";
		}
		else{
			print "you suck\n";
		}
	}
}

sub ScoreKeeper{
	$correctness = $_[0];
	$points = $_[1];
	$timeBonus = $_[2];

	if($correctness){
		print "Correct! :D \n";
		$currentScore += $points;
		print "You gained $points normal points\n";
		if($timeBonus != 9999){
			switch($timeBonus){
				#I don't think it's realistically possible to answer in less than 3 seconds given the way I have it set right now
				#so I'm just shifting these
				case ($timeBonus <= 3) { 
					printf(", and you answered in less than or equal to 3 seconds, 50% (%d point) bonus! :D\n", .5*$points);
					$currentScore+=.5*$points;
				}
				case 4 { 
					printf(", and you answered in less than 4 seconds, 40% (%d point) bonus! :\)\n", .4*$points);
					$currentScore+=.4*$points;
				}
				case 5 { 
					printf(", and you answered in less than 5 seconds, 30% (%d point) bonus! :\/\n", .3*$points);
					$currentScore+=.3*$points;
				}
				case 6 { 
					printf(", and you answered in less than 6 seconds, 20% (%d point) bonus! :|\n", .2*$points);
					$currentScore+=.2*$points;
				}
				case 7 { 
					printf(", and you answered in less than 7 seconds, 10% (%d point) bonus! :\(\n", .1*$points);
					$currentScore+=.1*$points;
				}
				else {
					print ", and you answered in more than 7 seconds, no bonus for you! Next!\n";
				}
			}
		}
		print "CURRENT SCORE = $currentScore\n";
	}
	else{
		print "Incorrect :( \n";
		$currentScore -= 2*$points;
		printf("You lost %d normal points, and now have $currentScore points\n", 2*$points);
	}
}
