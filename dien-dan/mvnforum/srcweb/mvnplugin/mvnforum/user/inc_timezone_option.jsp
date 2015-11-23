<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/user/inc_timezone_option.jsp,v 1.9 2007/07/10 08:50:35 hau_mvn Exp $
 - $Author: hau_mvn $
 - $Revision: 1.9 $
 - $Date: 2007/07/10 08:50:35 $
 -
 - ====================================================================
 -
 - Copyright (C) 2002-2007 by MyVietnam.net
 -
 - All copyright notices regarding mvnForum MUST remain 
 - intact in the scripts and in the outputted HTML.
 - The "powered by" text/logo with a link back to
 - http://www.mvnForum.com and http://www.MyVietnam.net in 
 - the footer of the pages MUST remain visible when the pages
 - are viewed on the internet or intranet.
 -
 - This program is free software; you can redistribute it and/or modify
 - it under the terms of the GNU General Public License as published by
 - the Free Software Foundation; either version 2 of the License, or
 - any later version.
 -
 - This program is distributed in the hope that it will be useful,
 - but WITHOUT ANY WARRANTY; without even the implied warranty of
 - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 - GNU General Public License for more details.
 -
 - You should have received a copy of the GNU General Public License
 - along with this program; if not, write to the Free Software
 - Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 -
 - Support can be obtained from support forums at:
 - http://www.mvnForum.com/mvnforum/index
 -
 - Correspondence and Marketing Questions can be sent to:
 - info at MyVietnam net
 -
 - @author: Minh Nguyen  
 - @author: Mai  Nguyen  
 --%>
<select name="<%=timeZoneSelectName%>">
<option value="-12"<% if (selectedTimeZone == -12) { %> selected="selected"<% } %>>(GMT - 12:00 hours) Enitwetok, Kwajalien</option>
<option value="-11"<% if (selectedTimeZone == -11) { %> selected="selected"<% } %>>(GMT - 11:00 hours) Midway Island, Samoa</option>
<option value="-10"<% if (selectedTimeZone == -10) { %> selected="selected"<% } %>>(GMT - 10:00 hours) Hawaii</option>
<option value="-9"<% if (selectedTimeZone == -9) { %> selected="selected"<% } %>>(GMT - 9:00 hours) Alaska</option>
<option value="-8"<% if (selectedTimeZone == -8) { %> selected="selected"<% } %>>(GMT - 8:00 hours) Pacific Time (US &amp; Canada)</option>
<option value="-7"<% if (selectedTimeZone == -7) { %> selected="selected"<% } %>>(GMT - 7:00 hours) Mountain Time (US &amp; Canada)</option>
<option value="-6"<% if (selectedTimeZone == -6) { %> selected="selected"<% } %>>(GMT - 6:00 hours) Central Time (US &amp; Canada), Mexico City</option>
<option value="-5"<% if (selectedTimeZone == -5) { %> selected="selected"<% } %>>(GMT - 5:00 hours) Eastern Time (US &amp; Canada), Bogota, Lima, Quito</option>
<option value="-4"<% if (selectedTimeZone == -4) { %> selected="selected"<% } %>>(GMT - 4:00 hours) Atlantic Time (Canada), Caracas, La Paz</option>
<option value="-3"<% if (selectedTimeZone == -3) { %> selected="selected"<% } %>>(GMT - 3:00 hours) Brazil, Buenos Aires, Georgetown, Falkland Is.</option>
<option value="-2"<% if (selectedTimeZone == -2) { %> selected="selected"<% } %>>(GMT - 2:00 hours) Mid-Atlantic, Ascention Is., St Helena</option>
<option value="-1"<% if (selectedTimeZone == -1) { %> selected="selected"<% } %>>(GMT - 1:00 hours) Azores, Cape Verde Islands</option>
<option value="0"<% if (selectedTimeZone == 0) { %> selected="selected"<% } %>>(GMT) Casablanca, Dublin, Edinburgh, London, Lisbon, Monrovia</option>
<option value="1"<% if (selectedTimeZone == 1) { %> selected="selected"<% } %>>(GMT + 1:00 hours) Berlin, Brussels, Copenhagen, Madrid, Paris, Rome</option>
<option value="2"<% if (selectedTimeZone == 2) { %> selected="selected"<% } %>>(GMT + 2:00 hours) Minsk, Kaliningrad, South Africa, Warsaw</option>
<option value="3"<% if (selectedTimeZone == 3) { %> selected="selected"<% } %>>(GMT + 3:00 hours) Baghdad, Riyadh, Moscow, Nairobi</option>
<option value="4"<% if (selectedTimeZone == 4) { %> selected="selected"<% } %>>(GMT + 4:00 hours) Adu Dhabi, Baku, Muscat, Tbilisi</option>
<option value="5"<% if (selectedTimeZone == 5) { %> selected="selected"<% } %>>(GMT + 5:00 hours) Ekaterinburg, Islamabad, Karachi, Tashkent</option>
<option value="6"<% if (selectedTimeZone == 6) { %> selected="selected"<% } %>>(GMT + 6:00 hours) Almaty, Colomba, Dhakra</option>
<option value="7"<% if (selectedTimeZone == 7) { %> selected="selected"<% } %>>(GMT + 7:00 hours) Ho Chi Minh, Hanoi, Bangkok, Jakarta</option>
<option value="8"<% if (selectedTimeZone == 8) { %> selected="selected"<% } %>>(GMT + 8:00 hours) Beijing, Hong Kong, Perth, Singapore, Taipei</option>
<option value="9"<% if (selectedTimeZone == 9) { %> selected="selected"<% } %>>(GMT + 9:00 hours) Osaka, Sapporo, Seoul, Tokyo, Yakutsk</option>
<option value="10"<% if (selectedTimeZone == 10) { %> selected="selected"<% } %>>(GMT + 10:00 hours) Melbourne, Papua New Guinea, Sydney</option>
<option value="11"<% if (selectedTimeZone == 11) { %> selected="selected"<% } %>>(GMT + 11:00 hours) Magadan, New Caledonia, Solomon Islands</option>
<option value="12"<% if (selectedTimeZone == 12) { %> selected="selected"<% } %>>(GMT + 12:00 hours) Auckland, Wellington, Fiji, Marshall Island</option>
</select>

