<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      id		</th>
 		<th width="80px">
		      hopitalName		</th>
 		<th width="80px">
		      address		</th>
 		<th width="80px">
		      type		</th>
 		<th width="80px">
		      iduser		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>&nbsp;&nbsp;
			<?php echo $row->id; ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->hopitalName; ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->address; ?>
		</td>
       		<td>
			<?php if($row->type == 0)
                   echo "Hospital";
                   else
                   	"Pharmacy";
			 ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->iduser0->username; ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
