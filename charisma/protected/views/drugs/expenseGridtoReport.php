<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      id		</th>
 		<th width="80px">
		      drug		</th>
 		<th width="80px">
		      generic		</th>
 		<th width="80px">
		      cash		</th>
		       <th width="80px">
		      Special		</th>
 		<th width="80px">
		      availability		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>
			<?php echo $row->id; ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->drug; ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php 
              if($row->generic == 1)
			        echo "Yes"; 
                else 
                   	echo "No";
			?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->cash; ?>
		</td>
		<td>&nbsp;&nbsp;
			<?php 
              if($row->special == 1)
			        echo "Yes"; 
                else 
                   	echo "No";
			?>
       		<td>
       		<td>&nbsp;&nbsp;
			<?php 
			if($row->availability == 1)
			        echo "Yes"; 
                else 
                   	echo "No";
			 ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
