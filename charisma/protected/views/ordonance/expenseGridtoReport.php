<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      id		</th>
 		<th width="80px">
		      eye		</th>
 		<th width="80px">
		      type		</th>
 		<th width="80px">
		      typeofglass		</th>
 		<th width="80px">
		      vision		</th>
 		<th width="80px">
		      lunette		</th>
 		<th width="80px">
		      interpupillarydistance		</th>
 		<th width="80px">
		      idinvoice		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>
			<?php echo $row->id; ?>
		</td>
       		<td>
			<?php echo $row->eye; ?>
		</td>
       		<td>
			<?php echo $row->type; ?>
		</td>
       		<td>
			<?php echo $row->typeofglass; ?>
		</td>
       		<td>
			<?php echo $row->vision; ?>
		</td>
       		<td>
			<?php echo $row->lunette; ?>
		</td>
       		<td>
			<?php echo $row->interpupillarydistance; ?>
		</td>
       		<td>
			<?php echo $row->idinvoice; ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
