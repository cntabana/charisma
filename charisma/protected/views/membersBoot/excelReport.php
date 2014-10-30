<?php if ($model !== null):?>
<table border="1">

	<tr>
		<th width="80px">
		      id		</th>
 		<th width="80px">
		      cardnumber		</th>
 		<th width="80px">
		      firstname		</th>
 		<th width="80px">
		      middlename		</th>
 		<th width="80px">
		      lastname		</th>
 		<th width="80px">
		      issuedate		</th>
 		<th width="80px">
		      expireddate		</th>
 		<th width="80px">
		      birthday		</th>
 		<th width="80px">
		      sex		</th>
 		<th width="80px">
		      phonenumber		</th>
 		<th width="80px">
		      address		</th>
 		<th width="80px">
		      email		</th>
 		<th width="80px">
		      iddistrict		</th>
 		<th width="80px">
		      idsector		</th>
 		<th width="80px">
		      nationality		</th>
 		<th width="80px">
		      status		</th>
 		<th width="80px">
		      type		</th>
 		<th width="80px">
		      photo		</th>
 		<th width="80px">
		      title		</th>
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
			<?php echo $row->sex; ?>
		</td>
       		<td>
			<?php echo $row->phonenumber; ?>
		</td>
       		<td>
			<?php echo $row->address; ?>
		</td>
       		<td>
			<?php echo $row->email; ?>
		</td>
       		<td>
			<?php echo $row->iddistrict; ?>
		</td>
       		<td>
			<?php echo $row->idsector; ?>
		</td>
       		<td>
			<?php echo $row->nationality; ?>
		</td>
       		<td>
			<?php echo $row->status; ?>
		</td>
       		<td>
			<?php echo $row->type; ?>
		</td>
       		<td>
			<?php echo $row->photo; ?>
		</td>
       		<td>
			<?php echo $row->title; ?>
		</td>
       	</tr>
     <?php endforeach; ?>
</table>
<?php endif; ?>
