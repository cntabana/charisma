<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      id		</th>
 		<th width="80px">
		      service		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>&nbsp;&nbsp;
			<?php echo $row->id; ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->service; ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
