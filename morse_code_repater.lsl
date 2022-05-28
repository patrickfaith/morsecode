//***********************************************************************************************************
//                                                                                                          *
//                                            --Morse Code Relay--                                                *
//                                                                                                          *
//***********************************************************************************************************
// Based on Morse code:
// www.lsleditor.org  by Alphons van der Heijden (SL: Alphons Jano)
//Creator: Bobbyb30 Swashbuckler
//Attribution: Original java work by Stephen C Phillips (C) 1999 and Michael R Ditto (C) 2001
//Created: March 9, 2007
//Last Modified:  December 3, 2009
//Released: Wed, December 2, 2009
//License: GNU GPL V3
//    Bobbyb30 Swashbuckler (C) 2009
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//Some parts taken from http://www.omnicron.com/~ford/java/NMorse.java

//Status: Fully Working/Production Ready
//Version: 1.2.7

//Name: Morse Code.lsl
//Purpose: To be able to convert to and from morse code and be able to play morse code in sound.
//Technical Overview: Uses a list and a string of characters to determine morse code. Uses 2 sounds to play.
//Description: This script will convert to and from morse code and can play morse code.
//Directions: This is meant to be used by scripters...the script has 3 functions which you can use...

//Compatible: Mono & LSL compatible
//Other items required: Correct sound UUIDs for dit and dah.
//Notes: Uses more than standard characters, commented for fellow scripters. Morse code is always capital.
//       Sounds dit and dah made in audacity using tone generator and sin wave
//       dit: Tone generator->frequency:800hz, amplitude:.5, length.05 @ 44.KHz
//       dah: Tone generator->frequency:800hz, amplitude:.5, length.15 @ 44.KHz
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//you may use a period . or a raised dot · or a bullet •
//you may use a dash,(hyphen, or minus) - or underscore _

//from http://www.omnicron.com/~ford/java/NMorse.java
string inputcharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.!,:?\\`'-/()\"=+;_$@&  ";

//string characters = "abcdefghijklmnopqrstuvwxyz0123456789.!,?'/()&:;=+-_\"$@";
list morsecodecharacters = [
    ".-",//A
    "-...",//B
    "-.-.",//c
    "-..",//D
    ".",//E
    "..-.",//F
    "--.",//G
    "....",//H
    "..",//I
    ".---",//J
    "-.-",//K
    ".-..",//L
    "--",//M
    "-.",//N
    "---",//O
    ".--.",//P
    "--.-",//Q
    ".-.",//R
    "...",//S
    "-",//T
    "..-",//U
    "...-",//V
    ".--",//W
    "-..-",//X
    "-.--",//Y
    "--..",//Z
    "-----",//0
    ".----",//1
    "..---",//2
    "...--",//3
    "....-",//4
    ".....",//5
    "-....",//6
    "--...",//7
    "---..",//8
    "----.",//9
    ".-.-.-",//. (period)
    "-.-.--",//! -this may not be a standard
    "--..--",//, -comma
    "---...",//: -colon
    "..--..",//? -question mark
    ".----.",//\ -backslash
    ".----.",//` treat ` as '
    ".----.",//' apostrophe
    "-....-",//-
    "-..-.",// /-foward slash , fraction bar
    "-.--.-",//( -Parenthesis open [(]-please note these are the same
    "-.--.-",//) - Parenthesis close [)]
    ".-..-.",//"-quotes
    "-...-",//=
    ".-.-.",//+
    "-.-.-.",//;
    "..--.-",//_
    "...-..-",//$
    ".--.-.",//@
    ".-...",//& Ampersand -http://en.wikipedia.org/wiki/Morse_code
    "  ",//space //you may rerange the bottom these two spaces so that your morse code does have space for /
    "  "//space-this second space doesn't have a space and is used for converting from morose code
        ];

string tomorsecode(string input)//converts to morse code from english
{
    input = llToUpper(input);//convert to upper as Morse code is in uppper case
    integer counter;
    integer inputlength = llStringLength(input);//speed hack here
    string morsecode;
    do
    {
        integer index = llSubStringIndex(inputcharacters,llGetSubString(input,counter,counter));//get a character
        if(index != -1)//speed hack here
        {//this means the character can be converted to morse code

            //pull out morse character from list and append a space
            morsecode += llList2String(morsecodecharacters,index) + " ";//mem hack here,
        }
        else//unknown character
        {
            morsecode += "?";//add question for unknown character
        }
    }while(++counter <inputlength);
    return morsecode;
}

string frommorsecode(string input)//converts from morse code to english
{
    //you could do some string replaces for other characters such as dots and bullets...but I'm lazy=D

    list inputlist = llParseString2List(input,[" "],["/"]);//parse out spaces, added "/" for / without spaces
    input = "";//remove input
    integer counter;
    integer inputlength = llGetListLength(inputlist);//speed hack here
    string english;
    do
    {
        //its pretty much the same procedure in reverse
        integer index = llListFindList(morsecodecharacters,[llList2String(inputlist,counter)]);
        if(index != -1)//speed hack here
        {//this means the character can be converted to morse code

            //pull out english character from inputstring
            english += llGetSubString(inputcharacters,index,index);//mem hack here,
        }
        else//unknown character
        {
            english += "?";//add question for unknown character
        }
    }while(++counter <inputlength);
    return english;
}

//sounds..you could actually use all the sounds for all the letters...but thats more work
//use t and e to make sounds at 10wpm

string ditsound = "98303801-d733-e49a-9bb1-34f140c35ca6";//short mark, dot or 'dit' .equals E .05 sec
string dahsound = "e2c6a9db-8bcc-d78f-7c69-732da1295542";//longer mark, dash or 'dah'-T .15 sec
//string ditsound = "bda8929e-0e34-f32d-340d-1226c1e0c5b5";//short mark, dot or 'dit' .equals E .1 sec
//string dahsound = "b35ac99d-86a5-1df1-eb8c-85966ac8b2a9";//longer mark, dash or 'dah'-T .3 sec
string errorsound = "539ae7d0-eaa3-1450-9014-316c24ea4721";//an error sound

//you may recalibrate sound times or change sounds for faster printing
float ditsoundwait = .05;//how long to wait after playing dit .05 seconds long
float dahsoundwait = .15;//how long to wait after playing dah.15 seconds long
float spacepause = .3;//how long to pause for spaces

//dashes and dots
string dit = ".";//the dot being used
string dah = "-";//the dash being used

//input should be given in morsecode
playmorsecode(string input)//plays morsecode in sound=D
{
    //similar to frommorsecode
    list inputlist = llParseString2List(input,[" "],["/"]);//parse out spaces,added to parse out / without spaces
    input = "";//remove input
    integer counter;
    integer inputlength = llGetListLength(inputlist);//speed hack here
    do
    {
        string morsecharacter = llList2String(inputlist,counter);//pull that morse character from the inputlist
        integer index = llListFindList(morsecodecharacters,[morsecharacter]);//check to make sure its valid morsecode
        if(index != -1)//speed hack here
        {
            //if its valid play the right sounds;
            integer morsecharacterlength = llStringLength(morsecharacter);//length of the morse character we're playing
            integer soundcounter;
            //llOwnerSay("c" + morsecharacter + "|" + (string)morsecharacterlength + "soundcounter:" + (string)soundcounter);//debug
            do
            {
                string character = llGetSubString(morsecharacter,soundcounter,soundcounter);
                if(character == dit)
                {
                    //llSay(0,"dit" + character);//debug
                    llTriggerSound(ditsound,1.0);
                    llSleep(ditsoundwait);//how long to wait after sound
                }
                else if(character == dah)
                {
                    //llSay(0,"dah" + character);//debug
                    llTriggerSound(dahsound,1.0);
                    llSleep(dahsoundwait);//how long to wait after sound
                }
                else//must be a space /
                {
                    llSleep(spacepause);
                    //llSay(0,"other" + character);//debug
                }

            }while(++soundcounter < morsecharacterlength);
            soundcounter = 0;//makes it work in lsleditor
        }
        else//unknown character
        {
            //llSay(0,"error");//debug
            llTriggerSound(errorsound,1.0);
        }
    }while(++counter <inputlength);
}

test()//this is a removable function that I used to make sure it ran correctly
{
    string testphrase= "the quick brown fox jumps right over the lazy dog";
    llOwnerSay(testphrase + "|" + frommorsecode(tomorsecode(testphrase)));
    //            string test = "HELLO WORLD!";
    //        string to = tomorsecode(test);
    //        string fro = frommorsecode(to);
    //        playmorsecode(to);
    //        llSay(0,"test:" + test);
    //        llSay(0,"t:" + to + "|" + fro);
    //        llSay(0,"f:" + tomorsecode(fro) + "|" + frommorsecode(tomorsecode(fro)));
    //        llSubStringIndex("1 "," ");

}

default
{
    state_entry()
    {
        //test();
        llOwnerSay("On the wiki at https://wiki.secondlife.com/wiki/Morse_Code");
        llOwnerSay("Morse Code.lsl' released under GNU GPL V3 by Bobbyb30 Swashbuckler (C) 2009");
        llOwnerSay(tomorsecode("Because nothing speaks 1337 like morse code."));
        playmorsecode(tomorsecode("Hello World"));
        llOwnerSay("Because nothing speaks 1337 like morse code.");
        llOwnerSay("I'll be listening on channel 0...use the folowing commands without <> or :\n "
            + "english <morse code goes here>: this will translate morse code to english\n"
            + "morsecode <english goes here>: this will translate english to morse code\n"
            + "play english <english goes here>: this will play the english in morse code\n"
            + "play morse <morse code goes here>: this will play the morse code.");
        llOwnerSay("Please input morse code using . (periods) and dashes as -");
        llOwnerSay("I only support the following english characters and their morse code counterparts:\n" + inputcharacters);
        llOwnerSay("Enjoy!");
        // llListen(0,"",llGetOwner(),"");//i advise against a 0 listener...but I didn't optimize this part
        llListen(0,"",NULL_KEY,"");
    }
    listen(integer channel, string name, key id, string msg)//not optimized...for example use
    {
        string cleanmsg = llStringTrim(llToLower(msg),STRING_TRIM);//trim head and tail
        //english
        //012345678
        if(llSubStringIndex(cleanmsg,"english ") == 0)
            llOwnerSay(frommorsecode(llGetSubString(cleanmsg,8,-1)));
        //morsecode
        //01234567891
        else if(llSubStringIndex(cleanmsg,"morsecode ") == 0)
            llOwnerSay(tomorsecode(llGetSubString(cleanmsg,10,-1)));
        //play english
        //01234567891123
        else if(llSubStringIndex(cleanmsg,"play english ") == 0)
            playmorsecode(tomorsecode(llGetSubString(cleanmsg,13,-1)));
        //play morse
        //012345678911
        else if(llSubStringIndex(cleanmsg,"play morse ") == 0)
            playmorsecode(llGetSubString(cleanmsg,11,-1));
    }
    changed(integer change)
    {
        if(change & CHANGED_OWNER)
        {
            llOwnerSay("Under new management...resetting.");
            llResetScript();
        }
    }
}
