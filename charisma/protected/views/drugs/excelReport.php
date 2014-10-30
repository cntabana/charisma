<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      Id		</th>
 		<th width="80px">
		      Drug		</th>
 		<th width="80px">
		      Generic		</th>
 		<th width="80px">
		      cash		</th>
		  <th width="80px">
		      Special		</th>
 		<th width="80px">
		      Availability		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>
			<?php echo $row->id; ?>
		</td>
       		<td>
			<?php echo $row->drug; ?>
		</td>
       		<td>
			<?php 
              if($row->generic == 1)
			        echo "Yes"; 
                else 
                   	echo "No";
			?>
		</td>
       		<td>
			<?php echo $row->cash; ?>
		</td>
		<td>
			<?php 
              if($row->special == 1)
			        echo "Yes"; 
                else 
                   	echo "No";
			?>
       		<td>
			<?php if($row->availability == 1)
			        echo "Yes"; 
                else 
                   	echo "No"; ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
