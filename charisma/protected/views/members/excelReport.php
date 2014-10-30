<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      id		</th>
 		<th width="80px">
		      Card Number		</th>
		      <th width="80px">
		     Title		</th>
 		<th width="80px">
		      Firstname		</th>
 		<th width="80px">
		      Other name		</th>
 		<th width="80px">
		      Surname		</th>
 		<th width="80px">
		      Issue Date		</th>
 		<th width="80px">
		      Expired Date		</th>
 		<th width="80px">
		      birthday		</th>
 		<th width="80px">
		      Gender		</th>
		      <th width="80px">
		      Email		</th>
		      <th width="80px">
		      District		</th>
		      <th width="80px">
		      Sector		</th>
 		<th width="80px">
		      Phone Number		</th>
 		<th width="80px">
		      Address		</th>
 		<th width="80px">
		      Nationality		</th>
 		<th width="80px">
		      Status		</th>
 		<th width="80px">
		      Type		</th>
 		
 	</tr>
	<?php foreach($model as $row): ?>
	<tr>
        		<td>
			<?php echo $row->id; ?>
		</td>
       		<td>
			<?php echo $row->cardnumber; ?>
		</td>
		<td>
			<?php echo $row->title; ?>
		</td>
       		<td>
			<?php echo $row->firstname; ?>
		</td>
       		<td>
			<?php echo $row->middlename; ?>
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
	           echo "Famele";
		   ?>
		</td>
       		<td>
			<?php echo $row->email; ?>
		</td>
		<td>
			<?php echo $row->iddistrict0->district; ?>
		</td>
		<td>
			<?php echo $row->idsector0->sector; ?>
		</td>
		
       		<td>
			<?php echo $row->phonenumber; ?>
		</td>
       		<td>
			<?php echo $row->address; ?>
		</td>
       		<td>
			<?php echo $row->nationality; ?>
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
		            echo "Staff";
			 ?>
		</td>
       		
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
