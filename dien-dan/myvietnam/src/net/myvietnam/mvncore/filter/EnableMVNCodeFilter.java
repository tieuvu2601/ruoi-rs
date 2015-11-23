/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/filter/EnableMVNCodeFilter.java,v 1.21.2.1 2008/11/18 11:08:36 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.21.2.1 $
 * $Date: 2008/11/18 11:08:36 $
 *
 * ====================================================================
 *
 * Copyright (C) 2002-2007 by MyVietnam.net
 *
 * All copyright notices regarding MyVietnam and MyVietnam CoreLib
 * MUST remain intact in the scripts and source code.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Correspondence and Marketing Questions can be sent to:
 * info at MyVietnam net
 *
 * @author: Minh Nguyen  
 * @author: Mai  Nguyen  
 */
package net.myvietnam.mvncore.filter;

public final class EnableMVNCodeFilter {

    private EnableMVNCodeFilter() { //prevent instantiation
    }

    static String[][] mvnCode = {
        { "[b]",    "<b>"  },
        { "[/b]",   "</b>" },
        { "[i]",    "<i>"  },
        { "[/i]",   "</i>" },
        { "[u]",    "<u>"  },
        { "[/u]",   "</u>" },
        { "[s]",    "<s>"  },
        { "[/s]",   "</s>" },

        { "[hr]",   "<hr>" },
        { "[br]",   "<br>" },
        { "[p]",    "<p>"  },

        { "[h1]",   "<h1>" },
        { "[/h1]",  "</h1>"},
        { "[h2]",   "<h2>" },
        { "[/h2]",  "</h2>"},
        { "[h3]",   "<h3>" },
        { "[/h3]",  "</h3>"},
        { "[h4]",   "<h4>" },
        { "[/h4]",  "</h4>"},
        { "[h5]",   "<h5>" },
        { "[/h5]",  "</h5>"},
        { "[h6]",   "<h6>" },
        { "[/h6]",  "</h6>"},

        { "[/size]",  "</font>" },
        { "[size=+1]",  "<font size=\"+1\">" },
        { "[size=+2]",  "<font size=\"+2\">" },
        { "[size=+3]",  "<font size=\"+3\">" },
        { "[size=+4]",  "<font size=\"+4\">" },
        { "[size=+5]",  "<font size=\"+5\">" },
        { "[size=+6]",  "<font size=\"+6\">" },

        { "[size=1]",  "<font size=\"1\">" },
        { "[size=2]",  "<font size=\"2\">" },
        { "[size=3]",  "<font size=\"3\">" },
        { "[size=4]",  "<font size=\"4\">" },
        { "[size=5]",  "<font size=\"5\">" },
        { "[size=6]",  "<font size=\"6\">" },

        { "[size=-1]",  "<font size=\"-1\">" },
        { "[size=-2]",  "<font size=\"-2\">" },
        { "[size=-3]",  "<font size=\"-3\">" },
        { "[size=-4]",  "<font size=\"-4\">" },
        { "[size=-5]",  "<font size=\"-5\">" },
        { "[size=-6]",  "<font size=\"-6\">" },

        { "[/font]",  "</font>" },
        { "[font=arial]",  "<font face=\"arial\">" },
        { "[font=times new roman]",  "<font face=\"times new roman\">" },
        { "[font=courier new]",  "<font face=\"courier new\">" },
        { "[font=century gothic]",  "<font face=\"Century Gothic\">" },

        { "[/color]",           "</span>" },
        { "[color=skyblue]",    "<span style=\"color: skyblue\">" },
        { "[color=royalblue]",  "<span style=\"color: royalblue\">" },
        { "[color=blue]",       "<span style=\"color: blue\">" },
        { "[color=darkblue]",   "<span style=\"color: darkblue\">" },
        { "[color=orange]",     "<span style=\"color: orange\">" },
        { "[color=orangered]",  "<span style=\"color: orangered\">" },
        { "[color=crimson]",    "<span style=\"color: crimson\">" },
        { "[color=red]",        "<span style=\"color: red\">" },
        { "[color=firebrick]",  "<span style=\"color: firebrick\">" },
        { "[color=darkred]",    "<span style=\"color: darkred\">" },
        { "[color=green]",      "<span style=\"color: green\">" },
        { "[color=limegreen]",  "<span style=\"color: limegreen\">" },
        { "[color=seagreen]",   "<span style=\"color: seagreen\">" },
        { "[color=deeppink]",   "<span style=\"color: deeppink\">" },
        { "[color=tomato]",     "<span style=\"color: tomato\">" },
        { "[color=coral]",      "<span style=\"color: coral\">" },
        { "[color=purple]",     "<span style=\"color: purple\">" },
        { "[color=indigo]",     "<span style=\"color: indigo\">" },
        { "[color=burlywood]",  "<span style=\"color: burlywood\">" },
        { "[color=sandybrown]", "<span style=\"color: sandybrown\">" },
        { "[color=sienna]",     "<span style=\"color: sienna\">" },
        { "[color=chocolate]",  "<span style=\"color: chocolate\">" },
        { "[color=teal]",       "<span style=\"color: teal\">" },
        { "[color=silver]",     "<span style=\"color: silver\">" },
        { "[color=brown]",      "<span style=\"color: brown\">" },
        { "[color=yellow]",     "<span style=\"color: yellow\">" },
        { "[color=olive]",      "<span style=\"color: olive\">" },
        { "[color=cyan]",       "<span style=\"color: cyan\">" },
        { "[color=violet]",     "<span style=\"color: violet\">" },
        { "[color=white]",      "<span style=\"color: white\">" },
        { "[color=black]",      "<span style=\"color: black\">" },
        { "[color=pink]",       "<span style=\"color: pink\">" },
        { "[color=purple]",     "<span style=\"color: purple\">" },
        { "[color=navy]",       "<span style=\"color: navy\">" },
        { "[color=beige]",      "<span style=\"color: beige\">" },

        { "[list]",             "<ul>" },
        { "[/list]",            "</ul>" },

        { "[list=1]",           "<ul type=\"1\">" },
        { "[/list=1]",          "</ul>" },

        { "[list=a]",           "<ul type=\"a\">" },
        { "[/list=a]",          "</ul>" },

        { "[list=A]",           "<ul type=\"A\">" },
        { "[/list=A]",          "</ul>" },

        { "[list=i]",           "<ul type=\"i\">" },
        { "[/list=i]",          "</ul>" },

        { "[list=I]",           "<ul type=\"I\">" },
        { "[/list=I]",          "</ul>" },

        { "[*]",                "<li>" },

        { "[code]",             "<div class=\"divcode\"><code class=\"prettyprint\">" },
        { "[/code]",            "</code></div>" },

        { "[quote]"      ,      "<div class=\"quote\">"},
        { "[/quote]"     ,      "</div>"},
    };

    public static String filter(String input) {
        
        int beginIndex = 0;
        int currentBracketIndex = 0;
        int inputLength = input.length();
        int mvnCodeLength = mvnCode.length;
        StringBuffer output = new StringBuffer(inputLength * 2);// is it the best init value ?

        while(beginIndex < inputLength) {
            currentBracketIndex = input.indexOf('[', beginIndex);
            if (currentBracketIndex == -1) { // cannot find bracket
                String remain = input.substring(beginIndex, inputLength);// slow here !
                output.append(remain);
                break;
            }

            // now it means we found the bracket
            String remain = input.substring(beginIndex, currentBracketIndex);// slow here !
            output.append(remain);
            boolean matchFound = false;

            // try to find if it matches any mvnCode
            for (int i = 0; i < mvnCodeLength; i++) {
                String currentEmotion = mvnCode[i][0];
                int endIndex = currentBracketIndex + currentEmotion.length();
                if (endIndex > inputLength) continue;
                String match = input.substring(currentBracketIndex, endIndex);// too slow here !!!
                if (currentEmotion.equals(match)) {
                    output.append(mvnCode[i][1]);
                    beginIndex = currentBracketIndex + currentEmotion.length();
                    matchFound = true;
                    break;
                }
            }// for

            if (matchFound == false) {
                beginIndex = currentBracketIndex + 1;
                output.append('[');
            }
        }// while
        return output.toString();
    }

    public static String removeBBCode(String input) {
        
        int beginIndex = 0;
        int currentBracketIndex = 0;
        int inputLength = input.length();
        int mvnCodeLength = mvnCode.length;
        StringBuffer output = new StringBuffer(inputLength * 2);// is it the best init value ?
        while(beginIndex < inputLength) {
            currentBracketIndex = input.indexOf('[', beginIndex);
            if (currentBracketIndex == -1) { // cannot find bracket
                String remain = input.substring(beginIndex, inputLength);// slow here !
                output.append(remain);
                break;
            }

            // now it means we found the bracket
            String remain = input.substring(beginIndex, currentBracketIndex);// slow here !
            output.append(remain);
            boolean matchFound = false;

            // try to find if it matches any mvnCode
            for (int i = 0; i < mvnCodeLength; i++) {
                String currentEmotion = mvnCode[i][0];
                int endIndex = currentBracketIndex + currentEmotion.length();
                if (endIndex > inputLength) continue;
                String match = input.substring(currentBracketIndex, endIndex);// too slow here !!!
                if (currentEmotion.equals(match)) {
                    output.append("");
                    beginIndex = currentBracketIndex + currentEmotion.length();
                    matchFound = true;
                    break;
                }
            }// for

            if (matchFound == false) {
                beginIndex = currentBracketIndex + 1;
                output.append('[');
            }
        }// while
        return output.toString();
    }
    /*
    public static void main(String[] args) {
        String input = " [][b]smile[/b] [ib][/i]]/b]) grin[)) sad = -[(cry[((minh[[>[)bdfdfc[";
        System.out.println("input = '" + input + "' length = " + input.length());
        EnableMVNCodeFilter enableMVNCodeFilter = new EnableMVNCodeFilter();

        long start = System.currentTimeMillis();
        String output = null;
        for (int i = 0; i <10000; i++) {
            output = enableMVNCodeFilter.filter(input);
        }
        long time = System.currentTimeMillis() - start;
        System.out.println("total time = " + time);

        System.out.println("output= '" + output + "'");
    }
    */
}
