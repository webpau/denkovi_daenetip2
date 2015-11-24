# denkovi_daenetip2
Ruby gem to control a DENKOVI DaenetIP2 using SNMP commands

To install
<code>gem install denkovi_daenetip2</code>

To use:<br/>
<code>irb</code><br/>
<code>require 'denkovi_daenetip2'</code><br/>
<code>=> true</code><br/>
<code>dae = DaenetIP2.new("[daenetip2_IP]",[daenetip2_SNMP_PORT],"[SNMP read-write community string]","[SNMP read-only community string]")</code><br/>
<code>=> true</code><br/>


To read P6:

<code>dae.read(1)</code><br/>
<code>=> 1020</code><br/>

To write P3

<code>dae.write('p3', [RELAY],[VALUE])</code><br/>
<code>dae.write('p3',1,0)</code><br/>
<code>=> true</code><br/>

To write P5

<code>dae.write('p5', [RELAY],[VALUE])</code><br/>
<code>dae.write('p5',1,0)</code><br/>
<code>=> true</code><br/>

To close

<code>dae.close</code><br/>
<code>=> true</code><br/>






