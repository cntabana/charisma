<?php if ($model !== null):?>
<table border="1">

	<tr>
		
 		<th width="70px">
		      cardnumber		</th>
		    
 		<th width="50px">
		      firstname		</th>
 		<th width="50px">
		      lastname		</th>
 		<th width="50px">
		      issuedate		</th>
 		<th width="50px">
		      expireddate		</th>
 		<th width="50px">
		      birthday		</th>
 		<th width="35px">
		      Gender		</th>
 		<th width="50px">
		      phonenumber		</th>
 		<th width="50px">
		      address		</th>
 		<th width="30px">
		      status		</th>
 		<th width="30px">
		      type		</th>
 		
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        	
			
       		<td>
			<?php echo $row->cardnumber; ?>
		</td>
		
       		<td>
			<?php echo $row->firstname; ?>
		</td>
       		<td>
			<?php echo $row->lastname; ?>
		</td>
       		<td>
			<?php echo $row->issuedate; ?>
		</td>
       		<td>
			<?php echo $row->expireddate; ?>
		</td>
       		<td>
			<?php echo $row->birthday; ?>
		</td>
       		<td>
			<?php 
			if($row->sex ==0)
				echo "Male"; 
	            else
	           echo "Famele"; ?>
		</td>
       		<td>
			<?php echo $row->phonenumber; ?>
		</td>
       		<td>
			<?php echo $row->address; ?>
		</td>
       		<td>
			<?php 
                if($row->status == 0)
					echo "Inactive";
					else
		            echo "Active";
			 ?>
		</td>
       		<td>
			<?php 
			if($row->type == 0)
					echo "Student";
					else
		            echo "Staff"; ?>
		</td>
       
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
