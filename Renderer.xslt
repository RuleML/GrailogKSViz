<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg">
<xsl:output method="xml" encoding="iso-8859-1" doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd" doctype-public="-//W3C//DTD SVG 1.1//EN" indent="yes"/>
	<!-- Root -->
	<xsl:template match="RuleML">
		<svg id="rootSVG" version="1.1" xmlns="http://www.w3.org/2000/svg" > <!-- Start SVG -->
			<defs>
				<!-- Arrow head -->
				<marker id="arrow" viewBox="0 0 15 15" refX="1" refY="6" markerUnits="strokeWidth" markerWidth="10" markerHeight="7" orient="auto">
					<path d="M0 1 L10 6 L0 11 L10 6 L0 6" style="stroke:black;stroke-width:2;fill:none;" />
				</marker>
				<!-- Variable Pattern -->
				<pattern id="hatched" patternTransform="rotate(45) " x="0" y="0" width="3.5" height="3.5" patternUnits="userSpaceOnUse" >
					<path d="M 0 0 l 0 3.5"  fill="none" stroke="#01A9DB" stroke-width="1" stroke-linecap="square"/>
				</pattern>
			</defs>
			<xsl:call-template name="Initialize"/> <!-- Knowledgebase -->
			<script type="text/javascript">
				document.getElementById('rootSVG').setAttribute('height', parseFloat(coordY));
				document.getElementById('rootSVG').setAttribute('width', parseFloat(maxCoordX) + horizSpace);
			</script>
		</svg> <!-- End SVG -->
	</xsl:template>							
	<!-- Applies all templates to Datalog, Hornlog RuleML/XML files without RuleML namespace and schema -->
	<xsl:template name="Initialize">
		<!-- Variables used to determine the maximum height and width of the SVG viewport and for all widths-->
		<!-- Variables used to determine the position and size of the SVG elements, length of strings found in nodes -->
		<script type="text/javascript">
			var maxCoordX = 70;
			var horizSpace = 60;
			var horizSpaceFunct = 16;
			var coordX = 70;
			var coordY = 120;
			var serializer = new XMLSerializer();
			var stringTemp = new String;
			var stringCompare = new String;
			var stringStart;
			var stringEnd;
		</script>
	<xsl:apply-templates select="Assert"/> 
	</xsl:template>
	<xsl:template match="Assert">
		<xsl:apply-templates/> <!-- <Implies>, <And>, <Atom>, <Equal>, <Expr> tags are possible -->
	</xsl:template> 
	<!-- Rule:  executes template for each Implies node -->
	<xsl:template match="Implies">
		<!-- Single-premise Rule:  Atom Implies Atom -->
		<xsl:if test="(count(current()/child::Atom))=2"> 
			<!-- Positions and counts of elements -->
			<xsl:variable name="positionImplies" select="count(current()/preceding-sibling::*) + 1"/>
			<xsl:variable name="countAtoms" select="count(current()/child::Atom)"/>
			<xsl:variable name="countContentAtom1" select="count(current()/child::Atom[position()=1]/child::*)"/>
			<xsl:variable name="countContentAtom2" select="count(current()/child::Atom[position()=2]/child::*)"/>
			<!-- Implies double_arrow -->
			<xsl:element name="path">
				<xsl:attribute name="id"><xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
				<xsl:attribute name="d"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:apply-templates select="Atom[position()=1]"/> <!-- Single-premise of the rule Atom Implies Atom -->
			<!-- Rounded rectangle 1 -->			
			<script type="text/javascript">
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>x) - 20);
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>y) - 60);
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),$countContentAtom1)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),$countContentAtom1)"/>length) + 40);
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('y');
				<!-- Determine height of 1st rounded rectangle using the starting position and largest y coordinate -->
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) - 50);	
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('width');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('height');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('x');
				coordY = coordY + 45;				
				<!-- Finding the maximum width of the svg file -->
				if (parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
				{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width);}
			</script>
				
			<xsl:apply-templates select="Atom[position()=2]"/> <!-- Head of the rule -->
			<!-- Rounded rectangle 2 + double arrow -->
			<script type="text/javascript">
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,1)"/>x) - 20);
				<!-- Determine starting y coordinate for 2nd rounded rectangle using the start position and height of the 1st rounded rectangle -->
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 32);
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,$countContentAtom2)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,$countContentAtom2)"/>length) + 40);
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('y');
				<!-- Determine height of 2nd rounded rectangle using the starting position and largest y coordinate -->
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y) - 15);	
				coordY=coordY+120;
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('width');
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('height');
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('x');
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>x) + 5;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c = <xsl:value-of select= "concat('double_arrow','Rule',$positionImplies)"/>a + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/> = 'M ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r + '';
				document.getElementById('<xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>').setAttribute('d', <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>);
				coordY=coordY+25;
				<!-- Finding the maximum width of the svg file -->
				if (parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
					{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width);}
			</script>
		</xsl:if>
		<!-- Single-premise Rule Equal Implies Equal -->
		<xsl:if test="(count(current()/child::Equal))=2"> 
			<!-- Positions and counts of elements -->
			<xsl:variable name="positionImplies" select="count(current()/preceding-sibling::*) + 1"/>
			<xsl:variable name="countEquals" select="count(current()/child::Equal)"/>
			<xsl:variable name="countContentEqual1" select="count(current()/child::Equal[position()=1]/child::*)"/>
			<xsl:variable name="countContentEqual2" select="count(current()/child::Equal[position()=2]/child::*)"/>
			<!-- Implies double_arrow -->
			<xsl:element name="path">
				<xsl:attribute name="id"><xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
				<xsl:attribute name="d"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:apply-templates select="Equal[position()=1]"/> <!-- Single-premise of the rule-->
			<!-- Rounded rectangle 1 -->			
			<script type="text/javascript">
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),1)"/>x) - 20);
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),1)"/>y) - 95);
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),$countContentEqual1)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),$countContentEqual1)"/>length) + 40);
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('x');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('y');
				<!-- Determine height of 1st rounded rectangle using the starting position and largest y coordinate -->
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) -50);	
				coordY=coordY+45;
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('width');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('height');
				<!-- Finding the maximum width of the svg file -->
				if (parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
					{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width);}
			</script>
			<xsl:apply-templates select="Equal[position()=2]"/> <!-- Head of the rule -->
			<!-- Rounded rectangle 2 + double arrow -->
			<script type="text/javascript">
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countEquals,1)"/>x) - 20);
				<!-- Determine starting y coordinate for 2nd rounded rectangle using the starting position and height of the 1st rounded rectangle -->
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 32);
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('x');
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('y');
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countEquals,$countContentEqual2)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countEquals,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countEquals,$countContentEqual2)"/>length) + 40);
				<!-- Determine height of 2nd rounded rectangle using the starting position and largest y coordinate -->
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y) - 50);	
				coordY=coordY+120;
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('width');
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('height');
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),1)"/>x) + 5;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/> = 'M ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r + '';
				document.getElementById('<xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>').setAttribute('d', <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>);
				coordY=coordY+25;
				<!-- Finding the maximum width of the svg file -->
				if (parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
				{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width);}
			</script>
		</xsl:if>  <!-- Single-premise Rule Equal Implies Equal -->
		<!-- Single Premise Rule:  Implies has child Atom and Equal -->
		<xsl:if test="count(current()/child::Equal)=1 and count(current()/child::Atom)=1">  <!-- Single-premise rule -->
			<!-- Positions and counts of elements -->
			<xsl:variable name="positionImplies" select="count(current()/preceding-sibling::*) + 1"/>
			<xsl:variable name="countAtoms" select="(count(current()/child::*))"/>
			<xsl:variable name="countEquals" select="(count(current()/child::*))"/>
			<!-- Implies double_arrow -->
			<xsl:element name="path">
				<xsl:attribute name="id"><xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
				<xsl:attribute name="d"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<!-- If Single Premise of Rule is Atom -->
			<xsl:if test="count(current()/child::Atom/preceding-sibling::*) = 0">
				<!-- Positions and counts of elements -->
				<xsl:variable name="countContentAtom1" select="count(current()/child::Atom[position()=1]/child::*)"/>
				<xsl:apply-templates select="Atom"/> <!-- Single-premise of the rule-->
				<!-- Rounded rectangle 1 -->			
				<script type="text/javascript">
					document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>x) - 20);
					document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>y) - 50);
					document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),$countContentAtom1)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),$countContentAtom1)"/>length) + 40);
					var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('y');
					<!-- Determine height of 1st rounded rectangle using the starting position and largest y coordinate -->
					document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) - 50);	
					var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('width');
					var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('height');
					var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('x');
					coordY = coordY + 45;
					<!-- Finding the maximum width of the svg file -->
					if (parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
						{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width);}
				</script>
			</xsl:if>  <!-- If Single Premise of Rule is Atom -->
			<!-- If Single Premise of Rule is Equal -->
			<xsl:if test="count(current()/child::Equal/preceding-sibling::*) = 0">
				<!-- Positions and counts of elements -->
				<xsl:variable name="countContentEqual1" select="count(current()/child::Equal[position()=1]/child::*)"/>
				<xsl:apply-templates select="Equal"/> <!-- Single-premise of the rule-->
				<!-- Rounded rectangle 1 -->			
				<script type="text/javascript">
					document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),1)"/>x) - 20);
					document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),1)"/>y) - 55);
					document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),$countContentEqual1)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countEquals*1)-1),$countContentEqual1)"/>length) + 40);
					var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('x');
					var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('y');
					<!-- Determine height of 1st rounded rectangle using the starting position and largest y coordinate -->
					document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) -50);	
					coordY=coordY+45;
					var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('width');
					var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('height');
					<!-- Finding the maximum width of the svg file -->
					if (parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
						{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width);}
				</script>
			</xsl:if>  <!-- Single Premise of Rule is Equal -->
			<xsl:if test= "count(current()/child::Atom/preceding-sibling::*) = 1">
				<!-- Positions and counts of elements -->
				<xsl:variable name="countContentAtom2" select="count(current()/child::Atom/child::*)"/>
				<xsl:apply-templates select="Atom"/> <!-- Conclusion of the rule -->
				<!-- Rounded rectangle 2 + double arrow -->
				<script type="text/javascript">
					document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,1)"/>x) - 20);
					<!-- Determine starting y coordinate for 2nd rounded rectangle using the starting position and height of the 1st rounded rectangle -->
					document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 32);
					document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,$countContentAtom2)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,$countContentAtom2)"/>length) + 40);
					var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('y');
					<!-- Determine height of 2nd rounded rectangle using the starting position and largest y coordinate -->
					document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y)-15);	
					coordY=coordY+120;
					var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('width');
					var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('height');
					var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('x');
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>x) + 5;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 20;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 20;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/> = 'M ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r + '';
					document.getElementById('<xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>').setAttribute('d', <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>);
					coordY=coordY+25;
					<!-- Finding the maximum width of the svg file -->
					if (parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
						{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width);}
				</script>
			</xsl:if>  <!-- If conclusion of rule is Atom -->
			<xsl:if test="count(current()/child::Equal/preceding-sibling::*) = 1">
				<!-- Positions and counts of elements -->
				<xsl:variable name="countContentEqual2" select="count(current()/child::Equal/child::*)"/>
				<xsl:apply-templates select="Equal"/> <!-- Conclusion of the rule is Equal-->
				<!-- Rounded rectangle 2 + double arrow -->
				<script type="text/javascript">
					document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,1)"/>x) - 20);
					<!-- Determine starting y coordinate for 2nd rounded rectangle using the starting position and height of the 1st rounded rectangle -->
					document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 32);
					document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,$countContentEqual2)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countAtoms,$countContentEqual2)"/>length) + 40);
					var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('x');
					var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('y');
					<!-- Determine height of 2nd rounded rectangle using the starting position and largest y coordinate -->
					document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y) -50);	
					coordY=coordY+120;
					var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('width');
					var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('height');
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,(($countAtoms*1)-1),1)"/>x) + 5;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 20;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 20;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
					var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/> = 'M ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r + '';
					document.getElementById('<xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>').setAttribute('d', <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>);
					coordY=coordY+25;
					<!-- Finding the maximum width of the svg file -->
					if (parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
						{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width);}
				</script>
			</xsl:if>  <!-- If conclusion of rule is Equal -->	
		</xsl:if>  <!-- Single Premise Rule:  Implies has child Atom and Equal -->
		<!-- Multi-premise rule -->
		<!-- Premise containing more than one Atom and/or Equal, conclusion of the rule is Equal -->
		<xsl:if test="(count(current()/child::Equal))=1 and (count(current()/child::And))=1">  
			<!-- Positions and counts of elements --> 
			<xsl:variable name="positionImplies" select="count(current()/preceding-sibling::*) + 1"/>
			<xsl:variable name="countEqualsInAnd" select="count(current()/child::And/child::*)"/>
			<xsl:variable name="countContentEqual" select="count(current()/child::Equal/child::*)"/>
			<xsl:element name="path">
				<xsl:attribute name="id"><xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
				<xsl:attribute name="d"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:apply-templates select="And"/>  <!-- Multi-premise of the rule -->
			<!-- Rounded rectangle 1 -->			
			<script type="text/javascript">
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>x) - 20);
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>y) - 60);  
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('width', <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width);
				<!-- Determine height of 1st rounded rectangle using the starting position and largest y coordinate -->
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>y) );
				coordY=coordY+45;	
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('width');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('height');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('x');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('y'); 
				<!-- Finding the maximum width of the svg file -->
				if (parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
					{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width);}
			</script> 
			<xsl:apply-templates select="Equal"/>   <!-- Conclusion of the rule -->
			<!-- Rounded rectangle 2 + double arrow -->
			<script type="text/javascript">
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,2,1)"/>x) - 20);
				<!-- Determine starting y coordinate for 2nd rounded rectangle using the starting position and height of the 1st rounded rectangle -->
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 32);
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,2,$countContentEqual)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,2,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,2,$countContentEqual)"/>length) + 40);
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('x');
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('y');
				<!-- Determine height of 2nd rounded rectangle using the starting position and largest y coordinate -->
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y) - 50);	
				coordY=coordY+120;
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('width');
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('height');
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>x) + 5;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/> = 'M ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r + '';
				document.getElementById('<xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>').setAttribute('d', <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>);
				coordY=coordY+25;
				<!-- Finding the maximum width of the svg file -->
				if (parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
					{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width);}
			</script>
		</xsl:if>  
		<!-- Premise containing more than one Atom and/or Equal, conclusion of the rule is Atom -->
		<xsl:if test="(count(current()/child::Atom))=1 and (count(current()/child::And))=1">  <!-- Multi-premise rule -->
			<!-- Positions and counts of elements --> 
			<xsl:variable name="positionImplies" select="count(current()/preceding-sibling::*) + 1"/>
			<xsl:variable name="countAtomsInAnd" select="count(current()/child::And/child::*)"/>
			<xsl:variable name="countContentAtom" select="count(current()/child::Atom/child::*)"/>
			<xsl:element name="path">
				<xsl:attribute name="id"><xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
				<xsl:attribute name="d"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="id"><xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/></xsl:attribute>
				<xsl:attribute name="rx">10</xsl:attribute>
				<xsl:attribute name="ry">10</xsl:attribute>
				<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
				<xsl:attribute name="height"/>
				<xsl:attribute name="width"/>
			</xsl:element>
			<xsl:apply-templates select="And"/>  <!-- Call template to draw the multi-premise of the rule -->
			<!-- Rounded rectangle 1 -->			
			<script type="text/javascript">
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>x) - 20);
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>y) - 60);  
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('width', <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width);
				<!-- Determine height of 1st rounded rectangle using the starting position and largest y coordinate -->
				document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>y) );
				coordY=coordY+45;	
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('width');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('height');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('x');
				var <xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>').getAttribute('y'); 
				<!-- Finding the maximum width of the svg file -->
				if (parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
					{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>width);}
			</script> 
			<xsl:apply-templates select="Atom"/>   <!-- Conclusion of the rule -->
			<!-- Rounded rectangle 2 + double arrow -->
			<script type="text/javascript">
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,2,1)"/>x) - 20);
				<!-- Determine starting y coordinate for 2nd rounded rectangle using the starting position and height of the 1st rounded rectangle -->
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 32);
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,2,$countContentAtom)"/>x) - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,2,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,2,$countContentAtom)"/>length) + 40);
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('y');
				<!-- Determine height of 2nd rounded rectangle using the starting position and largest y coordinate -->
				document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').setAttribute('height', parseFloat(coordY) - parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>y)-15);	
				coordY=coordY+120;
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('width');
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>height = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('height');
				var <xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>x = document.getElementById('<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>').getAttribute('x');
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>x) + 5;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b = parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>y) + parseFloat(<xsl:value-of select="concat('round_rect','1','Rule',$positionImplies)"/>height) + 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 13;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 10;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + 7;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r = <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b - 20;
				var <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/> = 'M ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>a + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>b + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>c + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>d + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>e + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>f + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>g + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>h + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>i + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>j + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>k + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>l + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>m + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>n + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>o + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>p + ' L ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>q + ' ' + <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>r + '';
				document.getElementById('<xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>').setAttribute('d', <xsl:value-of select="concat('double_arrow','Rule',$positionImplies)"/>);
				coordY=coordY+25;
				<!-- Finding the maximum width of the svg file -->
				if (parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width) <![CDATA[>]]> maxCoordX)
					{maxCoordX = parseFloat(<xsl:value-of select="concat('round_rect','2','Rule',$positionImplies)"/>width);}
			</script>
		</xsl:if>  
	</xsl:template>  <!-- Implies -->
  
	<!-- Draws the relations and equalities contained the in the premise of a multi-premise rule -->
	<xsl:template match="And">  
		<!-- Multi-premise rule -->
		<xsl:for-each select="./*"> <!-- For each child of And -->
			<xsl:variable name="NaryMPAtomPosition" select="count(preceding-sibling::*) + 1"/>
			<xsl:variable name="NaryMPImpliesPosition" select="count(parent::And/parent::Implies/preceding-sibling::*) + 1"/>	
			<xsl:variable name="positionBinaryMPEqual" select="count(preceding-sibling::*) + 1"/>
			<xsl:variable name="positionBinaryMPImplies" select="count(parent::And/parent::Implies/preceding-sibling::*) + 1"/>
			<!-- Count of descendants Expr used to determine spacing after predicate -->
			<xsl:variable name="countDescExprMPImplies" select="count(descendant::Expr)"/> 
			<xsl:variable name="countChildExprMPImplies" select="count(child::Expr)"/> 
			<xsl:if test = "ancestor-or-self::Atom">	
				<xsl:for-each select="./*">
					<!-- Position 1 is First term for Label Node form -->
					<!-- Relation is the Label Node -->
					<xsl:if test="(position()=1) and (ancestor-or-self::Rel)">						
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
							<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<!-- Step to the right -->
						<xsl:if test="$NaryMPAtomPosition=1">
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', 50);
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(coordY));
								<!-- 1st round rectangle width and height-->
								var <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = 0;
								var <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>height = 10;
							</script>
						</xsl:if>
						<!-- Start of a new row -->
						<xsl:if test="$NaryMPAtomPosition!=1">
							<script type="text/javascript">
								document.getElementById("<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>").setAttribute("x", parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,($NaryMPAtomPosition*1)-1,1)"/>x));
								document.getElementById("<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>").setAttribute("y", parseFloat(coordY));  
							</script>
						</xsl:if>
						<script type="text/javascript">											
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);
							var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x); 
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15;
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length);
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b;
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a - 15;
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b - 15;
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + 15;
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d - 15;
							var <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/> = 'M ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b + ' C ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d + '';
							document.getElementById('<xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('d', <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>);
							var <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>i = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c;
							var <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d + 20;
							var <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>k = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + 15;
							var <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>l = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d - 15;
							var <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>m = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + 15;
							var <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>n = <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j + 15;
							var <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/> = 'M ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d + ' C ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>k + ' ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>l + ' ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>m + ' ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>n + ' ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>i + ' ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('d', <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>);
							var <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>s = <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>i + 15;
							var <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>t = <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j + 15;
							var <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>u = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a - 15;
							var <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>v = <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j + 15;
							var <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/> = 'M ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>i + ' ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j + ' C ' + <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>s + ' ' + <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>t + ' ' + <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>u + ' ' + <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>v + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + ' ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('d', <xsl:value-of select="concat('curvePath3','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>);
							var <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>w = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a - 15; 
							var <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b - 15;
							var <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a - 15;
							var <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>z = <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j + 15;
							var <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/> = 'M ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b + ' C ' + <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>w + ' ' + <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x + ' ' + <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y + ' ' + <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>z + ' ' + <xsl:value-of select="concat('curvePath','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + ' ' + <xsl:value-of select="concat('curvePath2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('d', <xsl:value-of select="concat('curvePath4','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>);
						</script>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="./*">
					<!-- Next terms not including last term -->
					<xsl:if test="(position() &gt; 1) and (position()!=last())">
						<xsl:if test="ancestor-or-self::Var">
							<xsl:element name="polygon">
								<xsl:attribute name="id"><xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
								<xsl:attribute name="points"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>length) + 50);
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y);
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/> = '' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h + '';
								document.getElementById('<xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>);
							</script>
						</xsl:if>
						<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
							<xsl:element name="rect">
								<xsl:attribute name="id"><xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
								<xsl:attribute name="height"/>
								<xsl:attribute name="width"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>length) + 50);
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y);
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 20);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('height', 40);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 25);
							</script>
						</xsl:if>
						<xsl:if test="self::Expr">  <!-- If node is Expr -->
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>length));
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								coordX = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + 50;
								coordY = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y);
							</script>
							<xsl:variable name="countPositionsMP" select="count(preceding-sibling::*)+1"/> 
							<xsl:variable name="countFunctionsInMPAtom" select="count(preceding-sibling::Expr)+1"/> 
							<!-- If Expr is contained in Atom call template for nested function -->
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="concat('FunctionInMPMPRule',$NaryMPImpliesPosition)"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$NaryMPAtomPosition"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInMPAtom"/>
								<xsl:with-param name="index" select="$countFunctionsInMPAtom"/>
							</xsl:call-template>						
							<!-- Set length of function -->
							<script type="text/javascript">  
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 50; 
							</script> 
							<!-- Count of descendants Expr used to determine spacing after predicate -->
							<script type="text/javascript">
								coordY = coordY + 90 + ((<xsl:value-of select="$countDescExprMPImplies"/> - <xsl:value-of select="$countChildExprMPImplies"/>)*75);
							</script>
							<xsl:if test="$countDescExprMPImplies &gt; 0">
								<script type="text/javascript">
									coordY = coordY + 80;
								</script>
							</xsl:if>
						</xsl:if> <!-- If node is Expr -->
					</xsl:if> <!-- If node is greater than one and not last -->
					<!-- Last term -->
					<xsl:if test="position()=last()">
						<xsl:if test="ancestor-or-self::Var">
							<xsl:element name="polygon">
								<xsl:attribute name="id"><xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
								<xsl:attribute name="points"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">1.5</xsl:attribute>
								<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>length) + 50);
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y);
								coordY=coordY+110;  
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/> = '' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h + '';
								document.getElementById('<xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>);	
								<!-- 1st round rectangle width-->
								if ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40) <![CDATA[>]]> <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width)
								  {<xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40;}						
							</script>
							<!-- Path to begin at label node -->
							<script type="text/javascript">
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x);
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>y) - 20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 13;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
							</script>
						</xsl:if>
						<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
							<xsl:element name="rect">
								<xsl:attribute name="id"><xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
								<xsl:attribute name="height"/>
								<xsl:attribute name="width"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">1.5</xsl:attribute>
								<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>length) + 50);
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y);
								coordY=coordY+100;  
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 20);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('height', 40);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 25);
								<!-- 1st round rectangle width-->
								if ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40) <![CDATA[>]]> <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width)
								  {<xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40;}
							</script>
							<!-- Path to begin at label node -->
							<script type="text/javascript">
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x);
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>y) - 20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 18;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
							</script>
						</xsl:if>
						<xsl:if test="self::Expr">  <!-- If node is Expr -->
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">1.5</xsl:attribute>
								<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-1))"/>length));
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								coordX = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + 50;
								coordY = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y);
							</script>
							<!-- path to join all elements -->
							<script type="text/javascript">  
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x);
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y) - 20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + 35;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y) - 20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
							</script>
							<xsl:variable name="countPositionsMP" select="count(preceding-sibling::*)+1"/> 
							<xsl:variable name="countFunctionsInMPAtom" select="count(preceding-sibling::Expr)+1"/> 
							<!-- If Expr is contained in Atom call template for nested function -->
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="concat('FunctionInMPMPRule',$NaryMPImpliesPosition)"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$NaryMPAtomPosition"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInMPAtom"/>
								<xsl:with-param name="index" select="$countFunctionsInMPAtom"/>
							</xsl:call-template>						
							<!-- Set length of function -->
							<script type="text/javascript">  
								coordY = coordY + 110;
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 50; 
							</script> 
							<!-- Count of descendants Expr used to determine spacing after predicate -->
							<script type="text/javascript">
								coordY = coordY + 90 + ((<xsl:value-of select="$countDescExprMPImplies"/> - <xsl:value-of select="$countChildExprMPImplies"/>)*75);
							</script>
							<xsl:if test="$countDescExprMPImplies &gt; 0">
								<script type="text/javascript">
									coordY = coordY + 80;
								</script>
							</xsl:if>
							<!-- 1st round rectangle width-->
							<script type="text/javascript">
								if ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40) <![CDATA[>]]> <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width)
									{<xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40;}
							</script>	
						</xsl:if> <!-- If node is Expr -->
					</xsl:if>
				</xsl:for-each>
			</xsl:if> <!-- if Atom -->
			<!-- Binary rule, multi-premise -->
			<xsl:if test = "ancestor-or-self::Equal">	
				<xsl:for-each select="./*">
					<!-- First term -->
					<xsl:if test="position()=1">						
						<xsl:if test="ancestor-or-self::Var">
							<xsl:element name="polygon">
								<xsl:attribute name="id"><xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
								<xsl:attribute name="points"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<!-- Step to the right -->
							<xsl:if test="$NaryMPAtomPosition=1">
								<script type="text/javascript">
									document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(coordY));
									<!-- 1st round rectangle width and height-->
									var <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = 0;
									var <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>height = 10;
								</script>
							</xsl:if>
							<!-- Start of a new row -->
							<xsl:if test="$NaryMPAtomPosition!=1">
								<script type="text/javascript">
									document.getElementById("<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>").setAttribute("x", parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,($NaryMPAtomPosition*1)-1,1)"/>x));
									document.getElementById("<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>").setAttribute("y", parseFloat(coordY));
								</script>
							</xsl:if>
							<script type="text/javascript">							
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/> = '' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h + '';
								document.getElementById('<xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>);
							</script>
						</xsl:if>
						<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
							<xsl:element name="rect">
								<xsl:attribute name="id"><xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
								<xsl:attribute name="height"/>
								<xsl:attribute name="width"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<!-- Step to the right -->
							<xsl:if test="$NaryMPAtomPosition=1">
								<script type="text/javascript">
									document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(coordY));
									<!-- 1st round rectangle width and height-->
									var <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = 0;
									var <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>height = 10;
								</script>
							</xsl:if>
							<!-- Start of a new row -->
							<xsl:if test="$NaryMPAtomPosition!=1">
								<script type="text/javascript">
									document.getElementById("<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>").setAttribute("x", parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,($NaryMPAtomPosition*1)-1,1)"/>x));
									document.getElementById("<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>").setAttribute("y", parseFloat(coordY));
								</script>
							</xsl:if>
							<script type="text/javascript">				
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);	
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = parseFloat(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y')) +30;
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 20);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('height', 40);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 25);
							</script>
						</xsl:if>
						<xsl:if test="self::Expr">  <!-- If node is Expr -->
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							</xsl:element>
							<!-- Step to the right -->
							<xsl:if test="$NaryMPAtomPosition=1">
								<script type="text/javascript">
									document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(coordY));
									<!-- 1st round rectangle width and height-->
									var <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = 0;
									var <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>height = 10;
								</script>
							</xsl:if>
							<!-- Start of a new row -->
							<xsl:if test="$NaryMPAtomPosition!=1">
								<script type="text/javascript">
									document.getElementById("<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>").setAttribute("x", parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,($NaryMPAtomPosition*1)-1,1)"/>x));
									document.getElementById("<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>").setAttribute("y", parseFloat(coordY));
								</script>
							</xsl:if>
							<script type="text/javascript">
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								coordX = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
							</script>
							<xsl:variable name="countPositionsMP" select="count(preceding-sibling::*)+1"/> 
							<xsl:variable name="countFunctionsInMPAtom" select="count(preceding-sibling::Expr)+1"/> 
							<!-- If Expr is contained in Atom call template for nested function -->
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="concat('FunctionInMPMPRule',$NaryMPImpliesPosition)"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$NaryMPAtomPosition"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInMPAtom"/>
								<xsl:with-param name="index" select="$countFunctionsInMPAtom"/>
							</xsl:call-template>						
							<!-- Set length of function -->
							<script type="text/javascript">  
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 60; 
							</script> 
							
						</xsl:if> <!-- Node is Expr -->
					</xsl:if> <!-- First Term -->
				</xsl:for-each>
				<xsl:for-each select="./*">
					<!-- Second term -->
					<xsl:if test="position()=last()">
						<xsl:if test="ancestor-or-self::Var">
							<xsl:element name="polygon">
								<xsl:attribute name="id"><xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
								<xsl:attribute name="points"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1, $NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1, $NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + 40);
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y);
								coordY=coordY+30;
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/> = '' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>h + '';
								document.getElementById('<xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>);						
								
								<!-- 1st round rectangle width-->
								if ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40) <![CDATA[>]]> <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width)
								{<xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40;}
								
								<!-- Double path between elements that are equal -->
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>y) - 10;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a) +20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b);
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>y) - 5;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a) +20;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b);
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
							</script>
						</xsl:if> 
						<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
							<xsl:element name="rect">
								<xsl:attribute name="id"><xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
								<xsl:attribute name="height"/>
								<xsl:attribute name="width"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1, $NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1, $NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + 40);
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y)-30);
								coordY=coordY+30;
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = parseFloat(document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y')) +30;
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 20);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('height', 40);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 10);
								document.getElementById('<xsl:value-of select="concat('rect','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y) - 25);
															
								<!-- 1st round rectangle width-->
								if ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40) <![CDATA[>]]> <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width)
								{<xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40;}
								
								<!-- Double path between elements that are equal -->
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>y) - 10;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a) +20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b);
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>y) - 5;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a) +20;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b);
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
							</script>
						</xsl:if>
						<xsl:if test="self::Expr">  <!-- If node is Expr -->
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/></xsl:attribute>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1, $NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1, $NaryMPAtomPosition)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + 40);
								document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>y);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('x');
								coordX = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x);
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>').getAttribute('y');
							</script>
							<xsl:variable name="countPositionsMP" select="count(preceding-sibling::*)+1"/> 
							<xsl:variable name="countFunctionsInMPAtom" select="count(preceding-sibling::Expr)+1"/> 
							<!-- If Expr is contained in Atom call template for nested function -->
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="concat('FunctionInMPMPRule',$NaryMPImpliesPosition)"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$NaryMPAtomPosition"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInMPAtom"/>
								<xsl:with-param name="index" select="$countFunctionsInMPAtom"/>
							</xsl:call-template>						
							<!-- Set length of function -->
							<script type="text/javascript">  
								var <xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - 60; 
								
								<!-- 1st round rectangle width-->
								if ((parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40) <![CDATA[>]]> <xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width)
								  {<xsl:value-of select="concat('round_rect','1','Rule',$NaryMPImpliesPosition)"/>width = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>x) - parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,1)"/>x) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,position())"/>length) + 40;}
								
								<!-- Double path between elements that are equal -->
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>y) - 10;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a) +20;
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b);
								var <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b = parseFloat(<xsl:value-of select="concat('text','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition,(position()-last()+1))"/>y) - 5;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c = parseFloat(<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a) +20;
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d = parseFloat(<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b);
								var <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/> = 'M ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>a + ' ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>b + ' L ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>c + ' ' + <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>').setAttribute('d', <xsl:value-of select="concat('path2','MPRule',$NaryMPImpliesPosition,1,$NaryMPAtomPosition)"/>);
							</script> 
						</xsl:if> <!-- Node is Expr -->
					</xsl:if> 	<!-- if node is last -->			
					
				</xsl:for-each> 
				<!-- Count of descendants Expr used to determine spacing after predicate -->
					<script type="text/javascript">
						coordY = coordY + 90 + ((<xsl:value-of select="$countDescExprMPImplies"/> - <xsl:value-of select="$countChildExprMPImplies"/>)*75);
					</script>
					<xsl:if test="$countDescExprMPImplies &gt; 0">
						<script type="text/javascript">
							coordY = coordY + 120;
						</script>
					</xsl:if>
			</xsl:if> <!-- if Equal -->	
		</xsl:for-each> <!-- For each child of And -->
	</xsl:template> <!-- And -->
	
	<xsl:template match="Atom">
		<!-- N-ary Relation-->
		<xsl:if test="parent::Assert">
			<!-- Count of descendants Expr used to determine spacing after predicate -->
			<xsl:variable name="countDescExpr" select="count(descendant::Expr)"/> 
			<xsl:variable name="countChildExpr" select="count(child::Expr)"/> 
			<!-- Count of relations -->
			<xsl:variable name="countRelations" select="count(preceding-sibling::*) + 1"/>
			<xsl:for-each select="./*">
				<!-- First term Relation is Label Node -->
				<xsl:if test="position()=1">						
					<xsl:if test="ancestor-or-self::Rel">
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath','Relation',$countRelations)"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('x', 50);
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('y', parseFloat(coordY));
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('y');
							
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x); 
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>b = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 15;
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>c = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length);
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>d = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>b;
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>e = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a - 15;
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>f = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>b - 15;
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>g = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>c + 15;
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>h = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>d - 15;
							var <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/> = 'M ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>b + ' C ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>e + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>f + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>g + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>h + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>c + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>d + '';
							document.getElementById('<xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>').setAttribute('d', <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>);
												
							var <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>i = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>c;
							var <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>d + 20;
							var <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>k = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>c + 15;
							var <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>l = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>d - 15;
							var <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>m = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>c + 15;
							var <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>n = <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j + 15;
							var <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/> = 'M ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>c + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>d + ' C ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>k + ' ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>l + ' ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>m + ' ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>n + ' ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>i + ' ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>').setAttribute('d', <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>);
											
							var <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>s = <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>i + 15;
							var <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>t = <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j + 15;
							var <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>u = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a - 15;
							var <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>v = <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j + 15;
							var <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/> = 'M ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>i + ' ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j + ' C ' + <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>s + ' ' + <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>t + ' ' + <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>u + ' ' + <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>v + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a + ' ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>').setAttribute('d', <xsl:value-of select="concat('curvePath3','Relation',$countRelations)"/>);
											
							var <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>w = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a - 15; 
							var <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>x = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>b - 15;
							var <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>y = <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a - 15;
							var <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>z = <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j + 15;
															
							var <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/> = 'M ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>b + ' C ' + <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>w + ' ' + <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>x + ' ' + <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>y + ' ' + <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>z + ' ' + <xsl:value-of select="concat('curvePath','Relation',$countRelations)"/>a + ' ' + <xsl:value-of select="concat('curvePath2','Relation',$countRelations)"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>').setAttribute('d', <xsl:value-of select="concat('curvePath4','Relation',$countRelations)"/>);
						</script>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="./*">
				<!-- Next terms -->
				<xsl:if test="(position() &gt; 1) and (position()!=last())">
					<xsl:if test="self::Var">
						<xsl:element name="polygon">
							<xsl:attribute name="id"><xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
							<xsl:attribute name="points"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>length) + 50);
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Relation',$countRelations,1)"/>y);
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('y');
					
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) -25);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) -25);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 15);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) + 5);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) + 15);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>f = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) + 15);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) + 5);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 15);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/> = '' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>h + '';
							document.getElementById('<xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>);
						</script>
					</xsl:if>
					<xsl:if test="(self::Ind) or (self::Data)">
						<xsl:element name="rect">
							<xsl:attribute name="id"><xsl:value-of select="concat('rect','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
							<xsl:attribute name="height"/>
							<xsl:attribute name="width"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>length) + 50);
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Relation',$countRelations,1)"/>y);
							
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('y');
							
							document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + 20);
							document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').setAttribute('height', 40);
							document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 10);
							document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 25);
							
							var <xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>width = document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').getAttribute('width');
							var <xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>height = document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').getAttribute('height');
							var <xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>x = document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>y = document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').getAttribute('y');
						</script>
					</xsl:if>
					<xsl:if test="self::Expr">  <!-- If node is Expr -->
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Relation',$countRelations,position())"/></xsl:attribute>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>length));
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('x');
							coordX = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + 50;
						</script>
						<xsl:variable name="countPositions" select="count(preceding-sibling::*)+1"/> 
						<xsl:variable name="countFunctionsInAtom" select="count(preceding-sibling::Expr)+1"/> 
						<xsl:call-template name="NestedExpr">
							<xsl:with-param name="constantType" select="'FunctionInAtom'"/> 
							<xsl:with-param name="functionLevel" select="1"/>
							<xsl:with-param name="countType" select="$countRelations"/>
							<xsl:with-param name="countFunctInLevel" select="$countFunctionsInAtom"/>
							<xsl:with-param name="index" select="$countFunctionsInAtom"/>
						</xsl:call-template>						
						<!-- Set length of function -->
						<script type="text/javascript">  
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 50; 
						</script> 
					</xsl:if> <!-- If node is Expr -->
				</xsl:if>
				<!-- Last term -->
				<!-- Path begins at first term - the label node -->
				<xsl:if test="position()=last()">
					<xsl:if test="self::Var">
						<xsl:element name="polygon">
							<xsl:attribute name="id"><xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
							<xsl:attribute name="points"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('path','Relation',$countRelations)"/></xsl:attribute>
							<xsl:attribute name="fill">none</xsl:attribute>
							<xsl:attribute name="stroke">black</xsl:attribute>
							<xsl:attribute name="stroke-width">1.5</xsl:attribute>
							<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>length) + 50);
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Relation',$countRelations,1)"/>y);
							coordY=coordY+150; 
						
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('y');
							
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) -25);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) -25);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 15);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) + 5);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) + 15);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>f = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) + 15);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) + 5);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 15);
							var <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/> = '' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>h + '';
							document.getElementById('<xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','Relation',$countRelations,position())"/>);
							
							<!-- Finding the maximum width of the svg file -->
							if (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + horizSpace <![CDATA[>]]> maxCoordX)
							{maxCoordX = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + horizSpace;}
						
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>a = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-last()+1))"/>x);
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>b = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 20;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>c = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 13;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>d = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 20;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/> = 'M ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>a + ' ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>b + ' L ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>c + ' ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>d + '';
							document.getElementById('<xsl:value-of select="concat('path','Relation',$countRelations)"/>').setAttribute('d', <xsl:value-of select="concat('path','Relation',$countRelations)"/>);
						</script>
					</xsl:if>
					<xsl:if test="(self::Ind) or (self::Data)">
						<xsl:element name="rect">
							<xsl:attribute name="id"><xsl:value-of select="concat('rect','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
							<xsl:attribute name="height"/>
							<xsl:attribute name="width"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Relation',$countRelations,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('path','Relation',$countRelations)"/></xsl:attribute>
							<xsl:attribute name="fill">none</xsl:attribute>
							<xsl:attribute name="stroke">black</xsl:attribute>
							<xsl:attribute name="stroke-width">1.5</xsl:attribute>
							<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>length) + 50);
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Relation',$countRelations,1)"/>y);
							coordY=coordY+150;
							
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('y');
							
							document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + 20);
							document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').setAttribute('height', 40);
							document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 10);
							document.getElementById('<xsl:value-of select="concat('rect','Relation',$countRelations,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 25);
							
							<!-- Finding the maximum width of the svg file -->
							if (parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + horizSpace <![CDATA[>]]> maxCoordX)
							{maxCoordX = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length) + horizSpace;}
						
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>a = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-last()+1))"/>x);
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>b = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 20;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>c = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 18;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>d = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>y) - 20;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/> = 'M ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>a + ' ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>b + ' L ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>c + ' ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>d + '';
							document.getElementById('<xsl:value-of select="concat('path','Relation',$countRelations)"/>').setAttribute('d', <xsl:value-of select="concat('path','Relation',$countRelations)"/>);
						</script>
					</xsl:if> <!-- If last position is Ind or Data -->
					<!-- If last position is Expr -->
					<xsl:if test="self::Expr">  <!-- If node is Expr -->
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Relation',$countRelations,position())"/></xsl:attribute>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,(position()-1))"/>length));
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>').getAttribute('x');
							coordX = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + 50;
						</script>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('path','Relation',$countRelations)"/></xsl:attribute>
							<xsl:attribute name="fill">none</xsl:attribute>
							<xsl:attribute name="stroke">black</xsl:attribute>
							<xsl:attribute name="stroke-width">1.5</xsl:attribute>
							<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<!-- path to join all elements -->
						<script type="text/javascript">  
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>a = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,1)"/>length) + parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,1)"/>x);
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>b = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,1)"/>y) - 20;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>c = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) + 35;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/>d = parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,1)"/>y) - 20;
							var <xsl:value-of select="concat('path','Relation',$countRelations)"/> = 'M ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>a + ' ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>b + ' L ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>c + ' ' + <xsl:value-of select="concat('path','Relation',$countRelations)"/>d + '';
							document.getElementById('<xsl:value-of select="concat('path','Relation',$countRelations)"/>').setAttribute('d', <xsl:value-of select="concat('path','Relation',$countRelations)"/>);
						</script>
						<xsl:variable name="countPositions" select="count(preceding-sibling::*)+1"/> 
						<xsl:variable name="countFunctionsInAtom" select="count(preceding-sibling::Expr)+1"/> 
						<!-- call recursive template to draw function as an element in the relation -->
						<xsl:call-template name="NestedExpr">
							<xsl:with-param name="constantType" select="'FunctionInAtom'"/> 
							<xsl:with-param name="functionLevel" select="1"/>
							<xsl:with-param name="countType" select="$countRelations"/>
							<xsl:with-param name="countFunctInLevel" select="$countFunctionsInAtom"/>
							<xsl:with-param name="index" select="$countFunctionsInAtom"/>
						</xsl:call-template>				
						<!-- Set length of function -->
						<script type="text/javascript">  
							var <xsl:value-of select="concat('text','Relation',$countRelations,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','Relation',$countRelations,position())"/>x) - 50; 
							coordY = coordY + 150;
						</script> 							
					</xsl:if> <!-- If last node is Expr -->
				</xsl:if> <!-- If position = last -->
			</xsl:for-each>
			<!-- Count of descendants Expr used to determine spacing after predicate -->
			<script type="text/javascript">
				coordY = coordY + 80 + ((<xsl:value-of select="$countDescExpr"/> - <xsl:value-of select="$countChildExpr"/>)*70);
			</script>
		</xsl:if> <!-- If Parent Assert -->		
			
		<!-- N-ary rule, draws the body and conclusion of a single premise rule.  Draws the conclusion of a multi-premise rule -->
		<xsl:if test="parent::Implies">	
			<!-- Positions and counts of elements -->			
			<xsl:variable name="countRules" select="count(preceding-sibling::*) + 1"/>
			<xsl:variable name="positionImplies" select="count(parent::Implies/preceding-sibling::*) + 1"/>
			<!-- Count all children of And (Atom and Equal possible) -->
			<xsl:variable name="countAtomsInAnd" select="count(parent::Implies/child::And/child::*)"/> 
			<!-- Count of descendants Expr used to determine spacing after predicate -->
			<xsl:variable name="countDescExprImplies" select="count(descendant::Expr)"/> 
			<xsl:variable name="countChildExprImplies" select="count(child::Expr)"/> 
			<xsl:for-each select="./*">
				<!-- Position 1 is First term for Label Node form -->
				<!-- Relation is the Label Node -->
				<xsl:if test="position()=1">						
					<xsl:if test="ancestor-or-self::Rel">
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>		
						
						<!-- Start position of the premise of a single-premise rule -->
						<xsl:if test="$countRules=1">						
							<script type="text/javascript">						
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', 50);
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', parseFloat(coordY));
							</script>						
						</xsl:if>	
						<!-- Start position of the conclusion of a single-premise rule -->
						<xsl:if test="(($countRules=2) and not(count(parent::Atom/parent::Implies/child::And)=1))">	
							<script type="text/javascript">						
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,1,position())"/>x));
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', parseFloat(coordY));
							</script>
						</xsl:if>		
						<!-- Start position of the conclusion of a multi-premise rule -->
						<xsl:if test="(($countRules=2) and (count(parent::Atom/parent::Implies/child::And)=1))">	
							<script type="text/javascript">						
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$positionImplies,1,1,1)"/>x));
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', parseFloat(coordY));
							</script>
						</xsl:if>		
						<script type="text/javascript">															
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('y');

							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x); 
							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>b = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 15;
							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>c = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length);
							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>d = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>b;
							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>e = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a - 15;
							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>f = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>b - 15;
							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>g = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>c + 15;
							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>h = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>d - 15;
							var <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/> = 'M ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>b + ' C ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>e + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>f + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>g + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>h + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>c + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>d + '';
							document.getElementById('<xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>').setAttribute('d', <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>);
														
							var <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>i = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>c;
							var <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>d + 20;
							var <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>k = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>c + 15;
							var <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>l = <xsl:value-of select=
							"concat('curvePath','Rule',$positionImplies,$countRules,position())"/>d - 15;
							var <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>m = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>c + 15;
							var <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>n = <xsl:value-of select=
							"concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j + 15;
							
							var <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/> = 'M ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>c + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>d + ' C ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>k + ' ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>l + ' ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>m + ' ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>n + ' ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>i + ' ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>').setAttribute('d', <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>);
							
							var <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>s = <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>i + 15;
							var <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>t = <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j + 15;
							var <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>u = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a - 15;
							var <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>v = <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j + 15;
							var <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/> = 'M ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>i + ' ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j + ' C ' + <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>s + ' ' + <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>t + ' ' + <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>u + ' ' + <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>v + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a + ' ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>').setAttribute('d', <xsl:value-of select="concat('curvePath3','Rule',$positionImplies,$countRules,position())"/>);
							
							var <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>w = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a - 15; 
							var <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>x = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>b - 15;
							var <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>y = <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a - 15;
							var <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>z = <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j + 15;
															
							var <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/> = 'M ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>b + ' C ' + <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>w + ' ' + <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>x + ' ' + <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>y + ' ' + <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>z + ' ' + <xsl:value-of select="concat('curvePath','Rule',$positionImplies,$countRules,position())"/>a + ' ' + <xsl:value-of select="concat('curvePath2','Rule',$positionImplies,$countRules,position())"/>j + '';
							document.getElementById('<xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>').setAttribute('d', <xsl:value-of select="concat('curvePath4','Rule',$positionImplies,$countRules,position())"/>);
						</script>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="./*">
				<!-- Next terms -->
				<xsl:if test="position() &gt; 1 and position()!=last()">
					<xsl:if test="ancestor-or-self::Var">
						<xsl:element name="polygon">
							<xsl:attribute name="id"><xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
							<xsl:attribute name="points"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>length) + 50);
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>y);
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('y');

							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) -25);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) -25);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 15);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) + 5);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) + 15);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>f = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) + 15);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) + 5);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 15);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/> = '' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>h + '';
							document.getElementById('<xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>);
						</script>
					</xsl:if>
					<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
						<xsl:element name="rect">
							<xsl:attribute name="id"><xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
							<xsl:attribute name="height"/>
							<xsl:attribute name="width"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>length) + 50);
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>y);
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('y');
							
							document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length) + 20);
							document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/>').setAttribute('height', 40);
							document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 10);
							document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 25);
						</script>
					</xsl:if>
					<xsl:if test="self::Expr">  <!-- If node is Expr -->
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>length));
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('x');
							coordX = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + 50;
							coordY = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>y);
						</script>
						<xsl:variable name="countPositions" select="count(preceding-sibling::*)+1"/> 
						<xsl:variable name="countFunctionsInAtom" select="count(preceding-sibling::Expr)+1"/> 
						<!-- In order to have unique names the Expr in the premise and conclusion must have different constant names -->
						<!-- If Expr is contained in Atom of the conclusion of the rule call template for nested function -->
						<xsl:if test="$countRules = 2">
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="'FunctionInRuleC'"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$positionImplies"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInAtom"/>
								<xsl:with-param name="index" select="$countFunctionsInAtom"/>
							</xsl:call-template>
						</xsl:if>		
						<!-- If Expr is contained in Atom of the premise of the rule call template for nested function -->
						<xsl:if test="$countRules = 1">
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="'FunctionInRuleP'"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$positionImplies"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInAtom"/>
								<xsl:with-param name="index" select="$countFunctionsInAtom"/>
							</xsl:call-template>
						</xsl:if>									
						<!-- Set length of function -->
						<script type="text/javascript">  
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 50; 
						</script> 
					</xsl:if> <!-- If node is Expr -->
				</xsl:if> <!-- position greater than 1 and not last -->
				<!-- Last terms -->
				<xsl:if test="position()=last()">
					<xsl:if test="ancestor-or-self::Var">
						<xsl:element name="polygon">
							<xsl:attribute name="id"><xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
							<xsl:attribute name="points"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/></xsl:attribute>
							<xsl:attribute name="fill">none</xsl:attribute>
							<xsl:attribute name="stroke">black</xsl:attribute>
							<xsl:attribute name="stroke-width">1.5</xsl:attribute>
							<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>length) + 50);
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>y);
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('y');

							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) -25);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) -25);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 15);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) + 5);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) + 15);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>f = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) + 15);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) + 5);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 15);
							var <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/> = '' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>h + '';
							document.getElementById('<xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','Rule',$positionImplies,$countRules,position())"/>);
							
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-last()+1))"/>x);
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>b = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-last()+1))"/>y) - 20;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>c = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 13;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>d = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 20;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/> = 'M ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>a + ' ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>b + ' L ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>c + ' ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>d + '';
							document.getElementById('<xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>').setAttribute('d', <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>);
						</script>
					</xsl:if>
					<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
						<xsl:element name="rect">
							<xsl:attribute name="id"><xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
							<xsl:attribute name="height"/>
							<xsl:attribute name="width"/>
						</xsl:element>
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
							<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/></xsl:attribute>
							<xsl:attribute name="fill">none</xsl:attribute>
							<xsl:attribute name="stroke">black</xsl:attribute>
							<xsl:attribute name="stroke-width">1.5</xsl:attribute>
							<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>length) + 50);
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>y);
							stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>'));
							stringStart = stringTemp.indexOf("&gt;");
							stringEnd = stringTemp.lastIndexOf("&lt;");
							stringCompare = stringTemp.substring(stringStart+1, stringEnd);

							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('x');
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('y');
							
							document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length) + 20);
							document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/>').setAttribute('height', 40);
							document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 10);
							document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionImplies,$countRules,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 25);
						
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-last()+1))"/>x);
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>b = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-last()+1))"/>y) - 20;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>c = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 18;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>d = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>y) - 20;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/> = 'M ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>a + ' ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>b + ' L ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>c + ' ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>d + '';
							document.getElementById('<xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>').setAttribute('d', <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>);
						</script>
					</xsl:if>
					<!-- If last position is Expr -->
					<xsl:if test="self::Expr">  <!-- If node is Expr -->
						<xsl:element name="text">
							<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/></xsl:attribute>
						</xsl:element>
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,(position()-1))"/>length));
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>').getAttribute('x');
							coordX = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + 50;
							coordY = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>y);
						</script>
						<xsl:element name="path">
							<xsl:attribute name="id"><xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/></xsl:attribute>
							<xsl:attribute name="fill">none</xsl:attribute>
							<xsl:attribute name="stroke">black</xsl:attribute>
							<xsl:attribute name="stroke-width">1.5</xsl:attribute>
							<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>
							<xsl:attribute name="d"/>
						</xsl:element>
						<!-- path to join all elements -->
						<script type="text/javascript">  
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>x);
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>b = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>y) - 20;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>c = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) + 35;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>d = parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,1)"/>y) - 20;
							var <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/> = 'M ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>a + ' ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>b + ' L ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>c + ' ' + <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>d + '';
							document.getElementById('<xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>').setAttribute('d', <xsl:value-of select="concat('path','Rule',$positionImplies,$countRules)"/>);
						</script>
						<xsl:variable name="countPositions" select="count(preceding-sibling::*)+1"/> 
						<xsl:variable name="countFunctionsInAtom" select="count(preceding-sibling::Expr)+1"/> 
						<!-- call recursive template to draw function as an element in the relation -->
						<!-- In order to have unique names the Expr in the premise and conclusion must have different constant names -->
						<!-- If Expr is contained in Atom of the conclusion of the rule call template for nested function -->
						<xsl:if test="$countRules = 2">
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="'FunctionInRuleC'"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$positionImplies"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInAtom"/>
								<xsl:with-param name="index" select="$countFunctionsInAtom"/>
							</xsl:call-template>
						</xsl:if>		
						<!-- If Expr is contained in Atom of the premise of the rule call template for nested function -->
						<xsl:if test="$countRules = 1">
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="'FunctionInRuleP'"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$positionImplies"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInAtom"/>
								<xsl:with-param name="index" select="$countFunctionsInAtom"/>
							</xsl:call-template>
						</xsl:if>									
						<!-- Set length of function -->
						<script type="text/javascript">  
							var <xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','Rule',$positionImplies,$countRules,position())"/>x) - 50; 
						</script> 							
					</xsl:if> <!-- If last node is Expr -->
				</xsl:if>
			</xsl:for-each>
			<!-- Count of descendants Expr used to determine spacing after predicate -->
			<script type="text/javascript">
				coordY = coordY + 90 + ((<xsl:value-of select="$countDescExprImplies"/> - <xsl:value-of select="$countChildExprImplies"/>)*75);
			</script>
			<xsl:if test="$countDescExprImplies &gt; 0">
				<script type="text/javascript">
					coordY = coordY + 120;
				</script>
			</xsl:if>
		</xsl:if> <!-- Parent Implies -->
	</xsl:template> <!-- Atom Template -->
	
	<!-- template for nested function applications Expr -->
	<xsl:template name="NestedExpr">
		<!-- Nesting Level = 1 when parent is assert - starts at left hand side -->
		<xsl:param name="constantType" select="''"/> 
		<xsl:param name="functionLevel" select="1"/> 
		<xsl:param name="countType" select="0"/>
		<xsl:param name="countFunctInLevel" select="count(preceding-sibling::Expr) + 1"/>
		<xsl:param name="index" select="count(preceding-sibling::Expr) + 1"/>
		<!-- Count of preceding siblings Expr to distinguish between nested functions of siblings -->
		<xsl:variable name="countCurrentLevelFunctions" select="count(preceding-sibling::Expr) + 1"/> 
		<!-- Count of preceding siblings Expr to distinguish between functions in the same level -->
		<xsl:variable name="countFunctions" select="count(preceding-sibling::Expr) + 1"/> 
		<!-- Count of descendants Expr used to determine width of rectangle to enclose function -->
		<xsl:variable name="countDesc" select="count(descendant::Expr)"/> 
		<!-- Count of descendants Expr used to determine width of rectangle to enclose function -->
		<xsl:variable name="countChild" select="count(child::Expr)"/> 
		<!-- If first nesting level and parent is Atom, then start after previous node position in Atom -->				
		<xsl:if test="$functionLevel = 1">
			<script type="text/javascript">
				<!-- Determine x value using coordX which is updated after each term -->
				coordX = coordX + horizSpaceFunct;
			</script>
		</xsl:if>	
		<xsl:for-each select="./*">
			<!-- First term Function -->
			<xsl:if test="position()=1">	
				<xsl:if test="ancestor-or-self::Fun">
					<xsl:element name="path">
						<xsl:attribute name="id"><xsl:value-of select="concat('curvePath',$constantType ,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
						<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
						<xsl:attribute name="d"/>
					</xsl:element>
					<xsl:element name="path">
						<xsl:attribute name="id"><xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
						<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
						<xsl:attribute name="d"/>
					</xsl:element>
					<xsl:element name="path">
						<xsl:attribute name="id"><xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
						<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
						<xsl:attribute name="d"/>
					</xsl:element>
					<xsl:element name="path">
						<xsl:attribute name="id"><xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
						<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
						<xsl:attribute name="d"/>
					</xsl:element>
					<xsl:element name="text">
						<xsl:attribute name="id"><xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
					<!-- If first nesting level then start at left hand side -->				
					<xsl:if test="$functionLevel = 1">
						<script type="text/javascript">
							document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('x', coordX);
							document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('y', parseFloat(coordY)+45);
						</script>
					</xsl:if>
					<!-- If not first level then start after previous node position -->
					<!-- Determine y coordinate using first level function-->
					<xsl:if test="$functionLevel > 1">
						<script type="text/javascript">							
							<!-- Determine x value using coordX which is updated after each term -->
							coordX = coordX + horizSpaceFunct;
							document.getElementById('<xsl:value-of select="concat('text',$constantType, $countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('x', parseFloat(coordX));
							<!-- determine the y-value using the previous level function -->
							document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions, $countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,1,1,1,1,1)"/>y)+((<xsl:value-of select="$functionLevel"/>)-1)*40);
						</script>
					</xsl:if>
					<script type="text/javascript">				
						<!-- Draw rect4cave-shaped labelnode -->
						stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>'));
						stringStart = stringTemp.indexOf("&gt;");
						stringEnd = stringTemp.lastIndexOf("&lt;");
						stringCompare = stringTemp.substring(stringStart+1, stringEnd);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length = parseFloat(stringCompare.length* 9.609375);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x = parseFloat(coordX);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y = document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').getAttribute('y');
												
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a = parseFloat(coordX) - 15; 
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) - 30;
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length) + 30;
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b;
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>e = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + 15;
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>f = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b + 15;
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>g = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c - 15;
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>h = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + 15;
						var <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b + ' C ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>e + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>f + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>g + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>h + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + '';
						document.getElementById('<xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
													
						var <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>i = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c;
						var <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + 50;
						var <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>k = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c - 15;
						var <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>l = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + 15;
						var <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>m = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c - 15;
						var <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>n = <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j - 15;
						var <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + ' C ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>k + ' ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>l + ' ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>m + ' ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>n + ' ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>i + ' ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j + '';
						document.getElementById('<xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
						
						var <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>s = <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>i - 15;
						var <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>t = <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j - 15;
						var <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>u = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + 15;
						var <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>v = <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j - 15;
						var <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>i + ' ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j + ' C ' + <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>s + ' ' + <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>t + ' ' + <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>u + ' ' + <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>v + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j + '';
						document.getElementById('<xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('curvePath3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
						
						var <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>w = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + 15; 
						var <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>x = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b + 15;
						var <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>y = <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + 15;
						var <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>z = <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j - 15;
						var <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b + ' C ' + <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>w + ' ' + <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>x + ' ' + <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>y + ' ' + <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>z + ' ' + <xsl:value-of select="concat('curvePath',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('curvePath2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j + '';
						document.getElementById('<xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('curvePath4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
						coordX = coordX + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length)+50;
					</script>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="./*">
			<!-- Next terms -->
			<xsl:if test="(position() &gt; 1) and (position()!=last())">
				<xsl:if test="ancestor-or-self::Var">
					<xsl:element name="polygon">
						<xsl:attribute name="id"><xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
						<xsl:attribute name="points"/>
					</xsl:element>
					<xsl:element name="text">
						<xsl:attribute name="id"><xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
					<script type="text/javascript">
						document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('x', coordX);
						document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>y));
						stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>'));
						stringStart = stringTemp.indexOf("&gt;");
						stringEnd = stringTemp.lastIndexOf("&lt;");
						stringCompare = stringTemp.substring(stringStart+1, stringEnd);

						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length = parseFloat(stringCompare.length* 9.609375);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x = parseFloat(coordX);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y = document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').getAttribute('y');

						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>a = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) -25);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>b = (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) -25);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>c = (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) - 15);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>d = (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) + 5);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>e = (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) + 15);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>f = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) + 15);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>g = ((parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) + 5);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>h = ((parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) - 15);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/> = '' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>a + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>b + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>c + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>d + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>e + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>f + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>g + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>h + '';
						document.getElementById('<xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('points', <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>);
						coordX = coordX + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length) + 50;
					</script>
				</xsl:if>
				<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
					<xsl:element name="rect">
						<xsl:attribute name="id"><xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
						<xsl:attribute name="height"/>
						<xsl:attribute name="width"/>
					</xsl:element>
					<xsl:element name="text">
						<xsl:attribute name="id"><xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
					<script type="text/javascript">
						document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('x', parseFloat(coordX));
						document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>y));
						stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>'));
						stringStart = stringTemp.indexOf("&gt;");
						stringEnd = stringTemp.lastIndexOf("&lt;");
						stringCompare = stringTemp.substring(stringStart+1, stringEnd);

						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length = parseFloat(stringCompare.length* 9.609375);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x = parseFloat(coordX);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y = document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').getAttribute('y');
						document.getElementById('<xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length) + 20);
						document.getElementById('<xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('height', 40);
						document.getElementById('<xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) - 10);
						document.getElementById('<xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) - 25);									
						coordX = coordX + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length)+50);
					</script>
				</xsl:if>
				<!-- If element is a function then apply template Expr and level = level + 1 -->
				<xsl:if test="ancestor-or-self::Expr">
					<xsl:call-template name="NestedExpr">
						<xsl:with-param name="constantType" select="$constantType"/> 
						<xsl:with-param name="functionLevel" select="$functionLevel+1"/>
						<xsl:with-param name="countType" select="$countType"/>
						<xsl:with-param name="countFunctInLevel" select="$countFunctInLevel+$countCurrentLevelFunctions"/>
						<xsl:with-param name="index" select="$countFunctInLevel"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="./*">
			<!-- Last term -->
			<!-- Path begins at first term - the function node -->
			<xsl:if test="position()=last()">
				<!-- Draw Path from 1st element in first level to last element in first level -->
				<xsl:element name="path">
					<xsl:attribute name="id"><xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
					<xsl:attribute name="fill">none</xsl:attribute>
					<xsl:attribute name="stroke">black</xsl:attribute>
					<xsl:attribute name="stroke-width">1.5</xsl:attribute>
					<xsl:attribute name="marker-end">url(#arrow)</xsl:attribute>				
					<xsl:attribute name="d"/>
				</xsl:element>
				<script type="text/javascript">	
					<!-- Path from FunctionInAtom to last position -->
					var <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>length) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>x) + 7; 
					var <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>y) - 20;
					var <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c = parseFloat(coordX)-15;
					var <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>y) - 20;
					var <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b + ' L ' + <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c + ' ' + <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + '';
					document.getElementById('<xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('path',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
				</script>
				<!-- If element is a function then apply template NestedExpr -->
				<xsl:if test="ancestor-or-self::Expr">
					<xsl:call-template name="NestedExpr">
						<xsl:with-param name="constantType" select="$constantType"/> 
						<xsl:with-param name="functionLevel" select="$functionLevel+1"/>
						<xsl:with-param name="countType" select="$countType"/>
						<xsl:with-param name="countFunctInLevel" select="$countFunctInLevel+$countCurrentLevelFunctions"/>
						<xsl:with-param name="index" select="$countFunctInLevel"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="ancestor-or-self::Var">
					<xsl:element name="polygon">
						<xsl:attribute name="id"><xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
						<xsl:attribute name="points"/>
					</xsl:element>
					<xsl:element name="text">
						<xsl:attribute name="id"><xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
					<script type="text/javascript">
						document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('x', coordX);
						document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>y));
						stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>'));
						stringStart = stringTemp.indexOf("&gt;");
						stringEnd = stringTemp.lastIndexOf("&lt;");
						stringCompare = stringTemp.substring(stringStart+1, stringEnd);

						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length = parseFloat(stringCompare.length* 9.609375);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x = parseFloat(coordX);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y = document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').getAttribute('y');
						
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>a = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) -25);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>b = (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) -25);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>c = (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) - 15);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>d = (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) + 5);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>e = (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) + 15);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>f = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) + 15);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>g = ((parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) + 5);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>h = ((parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) - 15);
						var <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/> = '' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>a + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>b + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>c + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>d + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>e + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>f + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>g + ' ' + <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>h + '';
						document.getElementById('<xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('points', <xsl:value-of select="concat('polygon',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>);
						coordX = coordX + parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length);
					</script>
				</xsl:if>
				<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
					<xsl:element name="rect">
						<xsl:attribute name="id"><xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
						<xsl:attribute name="height"/>
						<xsl:attribute name="width"/>
					</xsl:element>
					<xsl:element name="text">
						<xsl:attribute name="id"><xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/></xsl:attribute>
						<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>	
					<script type="text/javascript">
						document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('x', parseFloat(coordX));
						document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>y));
						stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>'));
						stringStart = stringTemp.indexOf("&gt;");
						stringEnd = stringTemp.lastIndexOf("&lt;");
						stringCompare = stringTemp.substring(stringStart+1, stringEnd);

						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length = parseFloat(stringCompare.length* 9.609375);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x = parseFloat(coordX);
						var <xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y = document.getElementById('<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').getAttribute('y');
						
						document.getElementById('<xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length) + 20);
						document.getElementById('<xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('height', 40);
						document.getElementById('<xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>x) - 10);
						document.getElementById('<xsl:value-of select="concat('rect',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>y) - 25);
						coordX = coordX + (parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,position(),$index)"/>length));
					</script>
				</xsl:if>
				<!-- Rectangle to enclose FunctionInAtom (rect2cave-shape enclosing box) -->
				<xsl:element name="path">
					<xsl:attribute name="id"><xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
					<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
					<xsl:attribute name="d"/>
				</xsl:element>
				<xsl:element name="path">
					<xsl:attribute name="id"><xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
					<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
					<xsl:attribute name="d"/>
				</xsl:element>
				<xsl:element name="path">
					<xsl:attribute name="id"><xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
					<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
					<xsl:attribute name="d"/>
				</xsl:element>
				<xsl:element name="path">
					<xsl:attribute name="id"><xsl:value-of select="concat('curvePathExpr4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/></xsl:attribute>
					<xsl:attribute name="style">stroke:black;stroke-width:1;fill:none;</xsl:attribute>
					<xsl:attribute name="d"/>
				</xsl:element>
				<script type="text/javascript">						
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>x) - 25; 
				
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b = parseFloat(<xsl:value-of select="concat('text',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,1,$index)"/>y) - 85;
					
					coordX = coordX + 40;
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c = parseFloat(coordX);
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b;
					
					<!-- position and depth of curve for top -->
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>e = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + 10;
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>f = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b + 5;
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>g = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c - 5;
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>h = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + 10;
					var <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b + ' C ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>e + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>f + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>g + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>h + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + '';
					document.getElementById('<xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
					var <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>i = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c;
				</script>
				<!-- height of curved rectangle determined by number of descendants Expr -->
				<xsl:if test="$countDesc=0">
					<script type="text/javascript">
						var <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + 140;
					</script>
				</xsl:if>
				<xsl:if test="$countDesc>0">
					<script type="text/javascript">
						var <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + 210 + ((<xsl:value-of select="$countDesc"/> - <xsl:value-of select="$countChild"/>)*75);
					</script>
				</xsl:if>
				<script type="text/javascript">	
					var <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>c + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>d + ' L ' + <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>i + ' ' + <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j + '';
					document.getElementById('<xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
					
					var <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>s = <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>i - 10;
					var <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>t = <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j - 5;
					var <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>u = <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + 5;
					var <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>v = <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j - 10;
					var <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>i + ' ' + <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j + ' C ' + <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>s + ' ' + <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>t + ' ' + <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>u + ' ' + <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>v + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j + '';
					document.getElementById('<xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('curvePathExpr3',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
					var <xsl:value-of select="concat('curvePathExpr4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/> = 'M ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>b + ' L ' + <xsl:value-of select="concat('curvePathExpr',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>a + ' ' + <xsl:value-of select="concat('curvePathExpr2',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>j + '';
					document.getElementById('<xsl:value-of select="concat('curvePathExpr4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>').setAttribute('d', <xsl:value-of select="concat('curvePathExpr4',$constantType,$countType,$countFunctions,$countFunctInLevel,$functionLevel,$index)"/>);
					
					<!-- Finding the maximum width of the svg file -->
					if (coordX + horizSpace <![CDATA[>]]> maxCoordX)
					{maxCoordX = coordX + horizSpace;}
					coordX = coordX + 50 
				</script>
			</xsl:if>  <!-- last term -->
		</xsl:for-each>
	</xsl:template> <!-- Expr In Atom -->
	<!-- Template to draw Equal as binary predicate.  Draws Equal inside the premise and conclusion of single premise rule.  Draws Equal inside conclusion of a multi-premise rule -->
	<xsl:template match="Equal">
		<xsl:if test="count(current()/child::*) = 2">
			<xsl:if test="parent::Assert">
				<!-- Binary clause -->
				<!-- Count of descendants Expr used to determine spacing after predicate -->
				<xsl:variable name="countDescExprInEqual" select="count(descendant::Expr)"/> 
				<xsl:variable name="countChildExprInEqual" select="count(child::Expr)"/> 
				<!-- Count of Equals -->
				<xsl:variable name="countEquals" select="count(preceding-sibling::*) + 1"/>
				<xsl:for-each select="./*">
					<!-- First term -->
					<xsl:if test="position()=1">						
						<xsl:if test="ancestor-or-self::Var">
							<xsl:element name="polygon">
								<xsl:attribute name="id"><xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
								<xsl:attribute name="points"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Equal',$countEquals,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('x', 50);
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('y', parseFloat(coordY));
							
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);

								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y = parseFloat(document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('y')) - 30;

								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) +5);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) +5);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) +15);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 35);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 45);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>f = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 45);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 35);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) +15);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/> = '' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>h + '';
								document.getElementById('<xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>);
							</script>
						</xsl:if>
						<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
							<xsl:element name="rect">
								<xsl:attribute name="id"><xsl:value-of select="concat('rect','Equal',$countEquals,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
								<xsl:attribute name="height"/>
								<xsl:attribute name="width"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Equal',$countEquals,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('x', 50);
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('y', parseFloat(coordY));
								
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);

								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('y');
								
								document.getElementById('<xsl:value-of select="concat('rect','Equal',$countEquals,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + 20);
								document.getElementById('<xsl:value-of select="concat('rect','Equal',$countEquals,position())"/>').setAttribute('height', 30);
								document.getElementById('<xsl:value-of select="concat('rect','Equal',$countEquals,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) - 10);
								document.getElementById('<xsl:value-of select="concat('rect','Equal',$countEquals,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 10);
							</script>
						</xsl:if>
						<!-- First term is Function Application -->
						<xsl:if test="self::Expr">  <!-- If node is Expr -->
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Equal',$countEquals,position())"/></xsl:attribute>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('x', 50);
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('x');
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('y', parseFloat(coordY));
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('y');
								coordX = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x);
							</script>
							<xsl:variable name="countPositions" select="count(preceding-sibling::*)+1"/> 
							<xsl:variable name="countFunctionsInEqual" select="count(preceding-sibling::Expr)+1"/> 
							<!-- If Expr is contained in Equal call template for nested function -->
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="'FunctionInEqual'"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$countEquals"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInEqual"/>
								<xsl:with-param name="index" select="$countFunctionsInEqual"/>
							</xsl:call-template>
							<!-- Set length of function -->
							<script type="text/javascript">  
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) - 60; 
								coordY = coordY + 150; 
							</script> 								
						</xsl:if> <!-- If node is Expr -->
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="./*"> 					
					<!-- Second term -->
					<xsl:if test="position() &gt; 1">
						<xsl:if test="ancestor-or-self::Var">
							<xsl:element name="polygon">
								<xsl:attribute name="id"><xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
								<xsl:attribute name="points"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Equal',$countEquals,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','Equal',$countEquals)"/></xsl:attribute>
								<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','Equal',$countEquals)"/></xsl:attribute>
								<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>	
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>length) + 40);
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>y)+30);
								coordY=coordY+100;
							
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);

								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('y');
								
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) -15);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>f = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) -15);
								var <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/> = '' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>h + '';
								document.getElementById('<xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','Equal',$countEquals,position())"/>);
								
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>a = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>x) + 10; 
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>b = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>y) +20;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>c = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + 20;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>d = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/> = 'M ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + ' ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + ' L ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>c + ' ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','Equal',$countEquals)"/>').setAttribute('d', <xsl:value-of select="concat('path','Equal',$countEquals)"/>);
								
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>e = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a; 
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>f = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + 5;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>g = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + 20;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>h = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + 5;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/> = 'M ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>e + ' ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>f + ' L ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>g + ' ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>h + '';
								document.getElementById('<xsl:value-of select="concat('path2','Equal',$countEquals)"/>').setAttribute('d', <xsl:value-of select="concat('path2','Equal',$countEquals)"/>);
								coordY=coordY+30;
								<!-- Finding the maximum width of the svg file -->
								if (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + horizSpace <![CDATA[>]]> maxCoordX)
									{maxCoordX = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + horizSpace;}
							</script>
						</xsl:if>
						<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
							<xsl:element name="rect">
								<xsl:attribute name="id"><xsl:value-of select="concat('rect','Equal',$countEquals,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
								<xsl:attribute name="height"/>
								<xsl:attribute name="width"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Equal',$countEquals,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','Equal',$countEquals)"/></xsl:attribute>
								<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','Equal',$countEquals)"/></xsl:attribute>
								<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>	
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>length) + 40);
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>y);
								coordY=coordY+100;
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);

								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('y');
								
								document.getElementById('<xsl:value-of select="concat('rect','Equal',$countEquals,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + 20);
								document.getElementById('<xsl:value-of select="concat('rect','Equal',$countEquals,position())"/>').setAttribute('height', 30);
								document.getElementById('<xsl:value-of select="concat('rect','Equal',$countEquals,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) - 10);
								document.getElementById('<xsl:value-of select="concat('rect','Equal',$countEquals,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>y) + 10);
								
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>a = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>x) + 10; 
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>b = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>y) +20;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>c = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + 20;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>d = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/> = 'M ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + ' ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + ' L ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>c + ' ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','Equal',$countEquals)"/>').setAttribute('d', <xsl:value-of select="concat('path','Equal',$countEquals)"/>);
								
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>e = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a; 
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>f = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + 5;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>g = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + 20;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>h = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + 5;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/> = 'M ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>e + ' ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>f + ' L ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>g + ' ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>h + '';
								document.getElementById('<xsl:value-of select="concat('path2','Equal',$countEquals)"/>').setAttribute('d', <xsl:value-of select="concat('path2','Equal',$countEquals)"/>);
								coordY=coordY+30;
								<!-- Finding the maximum width of the svg file -->
								if (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + horizSpace <![CDATA[>]]> maxCoordX)
								{maxCoordX = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + horizSpace;}
							</script>
						</xsl:if>
						<!-- Second term is Function Application -->
						<xsl:if test="self::Expr">  <!-- If node is Expr -->
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','Equal',$countEquals)"/></xsl:attribute>
								<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','Equal',$countEquals)"/></xsl:attribute>
								<xsl:attribute name="style">stroke:black;stroke-width:2;fill:none</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>		
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Equal',$countEquals,position())"/></xsl:attribute>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>length));
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>').getAttribute('x');
								coordX = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + 39;
							</script>
							<xsl:variable name="countPositions" select="count(preceding-sibling::*)+1"/> 
							<xsl:variable name="countFunctionsInEqual" select="count(preceding-sibling::Expr)+1"/> 
							<xsl:if test="$countFunctionsInEqual &gt; 1">
								<script type="text/javascript">  
									coordY = coordY - 150;
								</script> 
							</xsl:if>
							<!-- If Expr is contained in Equal call template for nested function -->
							<xsl:call-template name="NestedExpr">
								<xsl:with-param name="constantType" select="'FunctionInEqual'"/> 
								<xsl:with-param name="functionLevel" select="1"/>
								<xsl:with-param name="countType" select="$countEquals"/>
								<xsl:with-param name="countFunctInLevel" select="$countFunctionsInEqual"/>
								<xsl:with-param name="index" select="$countFunctionsInEqual"/>
							</xsl:call-template>
							<!-- Set length of function -->
							<script type="text/javascript">  
								var <xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) - 50; 
								coordY = coordY + 150;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>a = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>x) + 10; 
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>b = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,(position()-1))"/>y) +20;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>c = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + 20;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/>d = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b;
								var <xsl:value-of select="concat('path','Equal',$countEquals)"/> = 'M ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + ' ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + ' L ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>c + ' ' + <xsl:value-of select="concat('path','Equal',$countEquals)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','Equal',$countEquals)"/>').setAttribute('d', <xsl:value-of select="concat('path','Equal',$countEquals)"/>);
								
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>e = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a; 
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>f = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + 5;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>g = <xsl:value-of select="concat('path','Equal',$countEquals)"/>a + 20;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/>h = <xsl:value-of select="concat('path','Equal',$countEquals)"/>b + 5;
								var <xsl:value-of select="concat('path2','Equal',$countEquals)"/> = 'M ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>e + ' ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>f + ' L ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>g + ' ' + <xsl:value-of select="concat('path2','Equal',$countEquals)"/>h + '';
								document.getElementById('<xsl:value-of select="concat('path2','Equal',$countEquals)"/>').setAttribute('d', <xsl:value-of select="concat('path2','Equal',$countEquals)"/>);
								coordY=coordY+30;
								<!-- Finding the maximum width of the svg file -->
								if (parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + horizSpace <![CDATA[>]]> maxCoordX)
									{maxCoordX = parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Equal',$countEquals,position())"/>length) + horizSpace;}
							</script> 							
						</xsl:if> <!-- If node is Expr -->
					</xsl:if> <!-- If second term -->
				</xsl:for-each>
				<!-- Count of descendants Expr used to determine spacing after binary predicate -->
				<script type="text/javascript">
					coordY = coordY+80+((<xsl:value-of select="$countDescExprInEqual"/> - <xsl:value-of select="$countChildExprInEqual"/>)*80);
				</script>
			</xsl:if> <!-- if parent is Assert -->
			<!-- Single Premise -->
			<xsl:if test="parent::Implies">		
				<!-- Positions and counts of elements -->
				<xsl:variable name="countEqualRules" select="count(preceding-sibling::*) + 1"/> 
				<xsl:variable name="positionEqualImplies" select="count(parent::Implies/preceding-sibling::*) + 1"/>
				<xsl:variable name="countSPEqualsInAnd" select="count(parent::Implies/child::And/child::*)"/> 
				<!-- Count of descendants Expr used to determine spacing after predicate -->
				<xsl:variable name="countDescExprImpliesEqual" select="count(descendant::Expr)"/> 
				<xsl:variable name="countChildExprImpliesEqual" select="count(child::Expr)"/> 
				<xsl:for-each select="./*">
					<!-- First term -->
					<xsl:if test="position()=1">						
						<xsl:if test="ancestor-or-self::Var">
							<xsl:element name="polygon">
								<xsl:attribute name="id"><xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
								<xsl:attribute name="points"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<!-- Step to the right - premise of a single-premise rule -->
							<xsl:if test="(($countEqualRules=1) and not(count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
								</script>
							</xsl:if>
							<!-- Step to the right - conclusion of a multi-premise rule -->
							<xsl:if test="(($countEqualRules=1) and (count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
								</script>
							</xsl:if> 
							<!-- Start of a new row - conclusion of single-premise rule premise Atom -->
							<xsl:if test="(($countEqualRules=2) and not(count(parent::Equal/parent::Implies/child::And)=1)and not(count(parent::Equal/parent::Implies/child::Equal)=2))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY) + 30);
								</script>
							</xsl:if>
							<!-- Start of a new row - conclusion of single-premise rule with premise Equal -->
							<xsl:if test="(($countEqualRules=2) and not(count(parent::Equal/parent::Implies/child::And)=1)and (count(parent::Equal/parent::Implies/child::Equal)=2))">	
								<!-- If premise starts with variable in position 1 do not need to adjust vertical spacing -->
								<xsl:if test="count(parent::Equal/parent::Implies/child::Equal[position()=1]/child::Var[position()=1])=1">
									<script type="text/javascript">						
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
									</script>
								</xsl:if>
								<!-- If premise starts with identity in position 1 adjust vertical spacing-->
								<xsl:if test="count(parent::Equal/parent::Implies/child::Equal[position()=1]/child::Var[position()=1])=0">
									<script type="text/javascript">						
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY)+25);
									</script>
								</xsl:if>
							</xsl:if>
							<!-- Start of a new row - conclusion of a multi-premise rule -->
							<xsl:if test="(($countEqualRules=2) and (count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$positionEqualImplies,1,1,1)"/>x));
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY)-5);		
								</script>
							</xsl:if> 
							<script type="text/javascript">	
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);

								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('y');

								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>f = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/> = '' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>h + '';
								document.getElementById('<xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>);
							</script>
						</xsl:if>
						<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
							<xsl:element name="rect">
								<xsl:attribute name="id"><xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;stroke:rgb(0,0,0)</xsl:attribute>
								<xsl:attribute name="height"/>
								<xsl:attribute name="width"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<!-- Step to the right - premise of a single-premise rule -->
							<xsl:if test="(($countEqualRules=1) and not(count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
								</script>
							</xsl:if>
							<!-- Step to the right - conclusion of a multi-premise rule -->
							<xsl:if test="(($countEqualRules=1) and (count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
								</script>
							</xsl:if> 
							<!-- Start of a new row - conclusion of single-premise rule premise Atom -->
							<xsl:if test="(($countEqualRules=2) and not(count(parent::Equal/parent::Implies/child::And)=1)and not(count(parent::Equal/parent::Implies/child::Equal)=2))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
								</script>
							</xsl:if>
							<!-- Start of a new row - conclusion of single-premise rule premise Equal -->
							<xsl:if test="(($countEqualRules=2) and not(count(parent::Equal/parent::Implies/child::And)=1)and (count(parent::Equal/parent::Implies/child::Equal)=2))">	
								<!-- If premise starts with variable in position 1 adjust vertical spacing -->
								<xsl:if test="count(parent::Equal/parent::Implies/child::Equal[position()=1]/child::Var[position()=1])=1">
									<script type="text/javascript">						
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY)-40);
									</script>
								</xsl:if>
								<!-- If premise starts with identity in position 1 do not need to adjust vertical spacing-->
								<xsl:if test="count(parent::Equal/parent::Implies/child::Equal[position()=1]/child::Var[position()=1])=0">
									<script type="text/javascript">						
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
									</script>
								</xsl:if>
							</xsl:if>
							<!-- Start of a new row - conclusion of a multi-premise rule -->
							<xsl:if test="(($countEqualRules=2) and (count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$positionEqualImplies,1,1,1)"/>x));
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY)-35);  							
								</script>
							</xsl:if>
							<script type="text/javascript">		
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);

								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y = parseFloat(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('y')) + 30; 
								document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length) + 20);
								document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('height', 40);
								document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) - 10);
								document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) - 25);
							</script>		
						</xsl:if>
						<!-- If first node is Expr -->
						<xsl:if test="self::Expr">  
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
							</xsl:element>
							<!-- Step to the right - premise of a single-premise rule -->
							<xsl:if test="(($countEqualRules=1) and not(count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
								</script>
							</xsl:if>
							<!-- Step to the right - conclusion of a multi-premise rule -->
							<xsl:if test="(($countEqualRules=1) and (count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', 50);
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
								</script>
							</xsl:if> 
							<!-- Start of a new row - conclusion of single-premise rule premise Atom -->
							<xsl:if test="(($countEqualRules=2) and not(count(parent::Equal/parent::Implies/child::And)=1)and not(count(parent::Equal/parent::Implies/child::Equal)=2))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY) + 30);
								</script>
							</xsl:if>
							<!-- Start of a new row - conclusion of single-premise rule with premise Equal -->
							<xsl:if test="(($countEqualRules=2) and not(count(parent::Equal/parent::Implies/child::And)=1)and (count(parent::Equal/parent::Implies/child::Equal)=2))">	
								<!-- If premise starts with variable in position 1 do not need to adjust vertical spacing -->
								<xsl:if test="count(parent::Equal/parent::Implies/child::Equal[position()=1]/child::Var[position()=1])=1">
									<script type="text/javascript">						
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY));
									</script>
								</xsl:if>
								<!-- If premise starts with identity in position 1 adjust vertical spacing-->
								<xsl:if test="count(parent::Equal/parent::Implies/child::Equal[position()=1]/child::Var[position()=1])=0">
									<script type="text/javascript">						
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,1,position())"/>x));
										document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY)+25);
									</script>
								</xsl:if>
							</xsl:if>
							<!-- Start of a new row - conclusion of a multi-premise rule -->
							<xsl:if test="(($countEqualRules=2) and (count(parent::Equal/parent::Implies/child::And)=1))">	
								<script type="text/javascript">						
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','MPRule',$positionEqualImplies,1,1,1)"/>x));
									document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(coordY)-5);		
								</script>
							</xsl:if> 
							<script type="text/javascript">
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('y');
								coordX = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x);
							</script>
							<xsl:variable name="countPositions" select="count(preceding-sibling::*)+1"/> 
							<xsl:variable name="countFunctionsInImpliesEqual" select="count(preceding-sibling::Expr)+1"/> 
							<!-- In order to have unique names the Expr in the premise and conclusion must have different constant names -->
							<!-- If Expr is contained in Atom of the premise of the rule call template for nested function -->
							<xsl:if test="$countEqualRules = 1">
								<xsl:call-template name="NestedExpr">
									<xsl:with-param name="constantType" select="'FunctionInRuleEqualP'"/> 
									<xsl:with-param name="functionLevel" select="1"/>
									<xsl:with-param name="countType" select="$positionEqualImplies"/>
									<xsl:with-param name="countFunctInLevel" select="$countFunctionsInImpliesEqual"/>
									<xsl:with-param name="index" select="$countFunctionsInImpliesEqual"/>
								</xsl:call-template>
							</xsl:if>			
							<!-- If Expr is contained in Atom of the conclusion of the rule call template for nested function -->
							<xsl:if test="$countEqualRules = 2">
								<xsl:call-template name="NestedExpr">
									<xsl:with-param name="constantType" select="'FunctionInRuleEqualC'"/> 
									<xsl:with-param name="functionLevel" select="1"/>
									<xsl:with-param name="countType" select="$positionEqualImplies"/>
									<xsl:with-param name="countFunctInLevel" select="$countFunctionsInImpliesEqual"/>
									<xsl:with-param name="index" select="$countFunctionsInImpliesEqual"/>
								</xsl:call-template>
							</xsl:if>								
							<!-- Set length of function -->
							<script type="text/javascript">  
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) - 60; 
								coordY = coordY + 150; 
							</script> 				
						</xsl:if> <!-- If first node is Expr -->
					</xsl:if> <!-- If first position --> 
				</xsl:for-each>
				<xsl:for-each select="./*">
					
					<!-- Second term -->
					<xsl:if test="position() &gt; 1">
						<xsl:if test="ancestor-or-self::Var">
							<xsl:element name="polygon">
								<xsl:attribute name="id"><xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill:url(#hatched); stroke-width:1;</xsl:attribute>
								<xsl:attribute name="points"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>x) + 40);
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,1)"/>y);
																
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);

								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('y');

								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>b = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) -25);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>c = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>d = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length) + 10) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>e = (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>f = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) + 15);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>g = ((parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) + 5);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>h = ((parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) - 10)) + ',' + (parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) - 15);
								var <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/> = '' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>a + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>b + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>c + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>d + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>e + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>f + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>g + ' ' + <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>h + '';
								document.getElementById('<xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('points', <xsl:value-of select="concat('polygon','Rule',$positionEqualImplies,$countEqualRules,position())"/>);
								
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>y) -10;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>c = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a +20;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>d = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/> = 'M ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a + ' ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b + ' L ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>c + ' ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>').setAttribute('d', <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>);
								
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>e = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>f = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b +5;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>g = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a +20;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>h = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b +5;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/> = 'M ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>e + ' ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>f + ' L ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>g + ' ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>h + '';
								document.getElementById('<xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>').setAttribute('d', <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>);
							</script>
						</xsl:if>
						<xsl:if test="(ancestor-or-self::Ind) or (ancestor-or-self::Data)">
							<xsl:element name="rect">
								<xsl:attribute name="id"><xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
								<xsl:attribute name="style">stroke:#000000; fill: none; stroke-width:1;</xsl:attribute>
								<xsl:attribute name="height"/>
								<xsl:attribute name="width"/>
							</xsl:element>
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
								<xsl:attribute name="style">font-size:16px;font-family:courier,monospace;</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<script type="text/javascript">	
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>x) + 40);
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,1)"/>y)-30);
															
								stringTemp = serializer.serializeToString(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>'));
								stringStart = stringTemp.indexOf("&gt;");
								stringEnd = stringTemp.lastIndexOf("&lt;");
								stringCompare = stringTemp.substring(stringStart+1, stringEnd);

								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length = parseFloat(stringCompare.length* 9.609375);
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y = parseFloat(document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('y')); 
								
								document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('width', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length) + 20);
								document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('height', 40);
								document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) - 10);
								document.getElementById('<xsl:value-of select="concat('rect','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y) +5);
								
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>y) -10;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>c = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a +20;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>d = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/> = 'M ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a + ' ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b + ' L ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>c + ' ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>').setAttribute('d', <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>);
								
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>e = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>f = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b +5;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>g = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a +20;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>h = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b +5;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/> = 'M ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>e + ' ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>f + ' L ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>g + ' ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>h + '';
								document.getElementById('<xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>').setAttribute('d', <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>);
							</script>	
						</xsl:if>
						<!-- If second node is Expr -->
						<xsl:if test="self::Expr">  
							<xsl:element name="text">
								<xsl:attribute name="id"><xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/></xsl:attribute>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<xsl:element name="path">
								<xsl:attribute name="id"><xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/></xsl:attribute>
								<xsl:attribute name="fill">none</xsl:attribute>
								<xsl:attribute name="stroke">black</xsl:attribute>
								<xsl:attribute name="stroke-width">2</xsl:attribute>
								<xsl:attribute name="d"/>
							</xsl:element>
							<script type="text/javascript">
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('x', parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>x) + 39);
								document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').setAttribute('y', <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,1)"/>y);
								
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('x');
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>y = document.getElementById('<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>').getAttribute('y');
								coordX = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x);
							</script>
							<xsl:variable name="countPositions" select="count(preceding-sibling::*)+1"/> 
							<xsl:variable name="countFunctionsInImpliesEqual" select="count(preceding-sibling::Expr)+1"/> 
							<xsl:if test="$countFunctionsInImpliesEqual &gt; 1">
								<script type="text/javascript">  
									coordY = coordY - 150;
								</script> 
							</xsl:if>
							<!-- In order to have unique names the Expr in the premise and conclusion must have different constant names -->
							<!-- If Expr is contained in Atom of the premise of the rule call template for nested function -->
							<xsl:if test="$countEqualRules = 1">
								<xsl:call-template name="NestedExpr">
									<xsl:with-param name="constantType" select="'FunctionInRuleEqualP'"/> 
									<xsl:with-param name="functionLevel" select="1"/>
									<xsl:with-param name="countType" select="$positionEqualImplies"/>
									<xsl:with-param name="countFunctInLevel" select="$countFunctionsInImpliesEqual"/>
									<xsl:with-param name="index" select="$countFunctionsInImpliesEqual"/>
								</xsl:call-template>
							</xsl:if>			
							<!-- If Expr is contained in Atom of the conclusion of the rule call template for nested function -->
							<xsl:if test="$countEqualRules = 2">
								<xsl:call-template name="NestedExpr">
									<xsl:with-param name="constantType" select="'FunctionInRuleEqualC'"/> 
									<xsl:with-param name="functionLevel" select="1"/>
									<xsl:with-param name="countType" select="$positionEqualImplies"/>
									<xsl:with-param name="countFunctInLevel" select="$countFunctionsInImpliesEqual"/>
									<xsl:with-param name="index" select="$countFunctionsInImpliesEqual"/>
								</xsl:call-template>
							</xsl:if>								
							<!-- Set length of function -->
							<script type="text/javascript">  
								var <xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>length = coordX - parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,position())"/>x) - 60; 
								coordY = coordY + 150; 
							</script> 	
							<script type="text/javascript">  
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>length) + parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>x) + 10;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b = parseFloat(<xsl:value-of select="concat('text','Rule',$positionEqualImplies,$countEqualRules,(position()-last()+1))"/>y) -10;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>c = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a +20;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>d = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b;
								var <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/> = 'M ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a + ' ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b + ' L ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>c + ' ' + <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>d + '';
								document.getElementById('<xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>').setAttribute('d', <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>);
											
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>e = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>f = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b +5;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>g = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>a +20;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>h = <xsl:value-of select="concat('path','Rule',$positionEqualImplies,$countEqualRules)"/>b +5;
								var <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/> = 'M ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>e + ' ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>f + ' L ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>g + ' ' + <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>h + '';
								document.getElementById('<xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>').setAttribute('d', <xsl:value-of select="concat('path2','Rule',$positionEqualImplies,$countEqualRules)"/>);							
							</script> 
						</xsl:if> <!-- If second node is Expr -->
					</xsl:if>  <!-- If second term -->
				</xsl:for-each>
				<!-- Count of descendants Expr used to determine spacing after predicate -->
				<xsl:if test="$countChildExprImpliesEqual &gt; 0">
					<script type="text/javascript">
						coordY = coordY + 90 + ((<xsl:value-of select="$countDescExprImpliesEqual"/> - <xsl:value-of select="$countChildExprImpliesEqual"/>)*55);
					</script>
				</xsl:if>
				<!-- If no Expr in Equal determine spacing after predicate -->
				<xsl:if test="$countChildExprImpliesEqual = 0">
				  <script type="text/javascript">
					coordY = coordY + 120;
				  </script>
				</xsl:if>
			</xsl:if> <!--if parent is Implies -->
		</xsl:if> <!-- if Equal is binary clause-->
	</xsl:template> <!-- end Equal template -->
	<!-- Relation -->
	<xsl:template match="Rel">
	</xsl:template>
</xsl:stylesheet>