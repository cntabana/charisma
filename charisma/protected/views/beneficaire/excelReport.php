<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="25px">
		      id		</th>
 		
 		<th width="50px">
		      Firstname		</th>
 		<th width="50px">
		      Othername		</th>
 		<th width="50px">
		      Surname		</th>
 		<th width="60px">
		      Date of Birth		</th>
 		<th width="60px">
		      Gender		</th>
 		<th width="60px">
		      type		</th>
 		<th width="150px">
		      Member		</th>
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>&nbsp;&nbsp;
			<?php echo $row->id; ?>
		</td>
       		
       		<td>&nbsp;&nbsp;
			<?php echo $row->firstname; ?>
		</td>
       		<td>
			<?php echo $row->middlename; ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->lastname; ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->dateofbirth; ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php 
             if($row->sex ==0)
				echo "Male"; 
	            else
	           echo "Female";
		   ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php 
                  if($row->type == 2)
					echo "Infant";
					else
		            echo "Conjoint";
			 ?>
		</td>
       		<td>&nbsp;&nbsp;
			<?php echo $row->idmember0->firstname.' '.$row->idmember0->middlename.' '.$row->idmember0->lastname; ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
