<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="30px">
		      Id		</th>
 		<th width="60px">
		      Date		</th>
 		<th width="120px">
		      Member		</th>
 		<th width="160px">
		      Hospital		</th>
 		<th width="60px">
		      Status		</th>
 		<th width="60px">
		      Type		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>&nbsp;
			<?php echo $row->id; ?>
		</td>
       		<td>&nbsp;
			<?php echo $row->date; ?>
		</td>
       		<td>&nbsp;
			<?php echo $row->idmember0->firstname.' '.$row->idmember0->middlename.' '.$row->idmember0->lastname; ?>
		</td>
       		<td>&nbsp;
			<?php echo $row->idhospital0->hopitalName; ?>
		</td>
       		<td>&nbsp;
			<?php if($row->status==0)
                     echo "Pending";
                   else
                   	  echo "Done";
			 ?>
		</td>
       		<td>&nbsp;
			<?php 
			if( $row->type== 1)
                   echo "Analyse";
            else if( $row->type== 2)
            	 echo "Traitement";
            else if( $row->type== 3)
            	 echo "Lunette";
            else 
            	 echo "Pharmacy";
			 ?>
		</td>
		
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
