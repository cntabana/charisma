<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      id		</th>
 		<th width="80px">
		      district		</th>
 		<th width="80px">
		      idprovince		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>
			<?php echo $row->id; ?>
		</td>
       		<td>
			<?php echo $row->district; ?>
		</td>
       		<td>
			<?php echo $row->idprovince; ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
