<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      id		</th>
 		<th width="80px">
		      medical_act		</th>
 		<th width="80px">
		      idservice		</th>
 		<th width="80px">
		      type		</th>
 		<th width="80px">
		      transfer		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>
			<?php echo $row->id; ?>
		</td>
       		<td>
			<?php echo $row->medical_act; ?>
		</td>
       		<td>
			<?php echo $row->idservice0->service; ?>
		</td>
       		<td>
			<?php 
                if($row->type == 1)
			        echo "Analyse"; 
                else if($row->type == 2)
                	echo "Traitment";
			    ?>
		</td>
       		<td>
			<?php  
              if($row->transfer == 1)
			    echo "Yes"; 
                else 
                 echo "No";  ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
