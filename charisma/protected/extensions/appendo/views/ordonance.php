<table class="appendo-gii" id="<?php echo $id ?>" width = '70%'>
	
	<thead>
		<tr>
			<th>.</th>
            <th>Eye</th>
            <th>Type</th>
            <th>Vision</th>
            <th>Distance</th>
            <th>Type de verre</th>
            <th>Lunette</th>
		</tr>
	</thead>
	<tbody>
    <?php 
//$model = new Ordonance;

    if ($model->idinvoice == null): ?>
		<tr>
	
                <td><?php  echo CHtml::hiddenField('idinvoice[]',$_GET['idinvoice'],array('style'=>'width:90px','readonly'=>true)); ?></td>
                <td><?php echo CHtml::textField('eye[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('type[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('typeofglass[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('vision[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('lunette[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('interpupillarydistance[]','',array('style'=>'width:150px')); ?></td>
		</tr>
    <?php else: ?>
        <?php for($i = 0; $i < sizeof($model->idinvoice); ++$i): ?>
    		<tr>
    			<td><?php echo CHtml::textField('idinvoice[]',$model->idinvoice[$i],array('style'=>'width:20px')); ?></td>
                <td><?php echo CHtml::textField('eye[]',$model->eye[$i],array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('type[]',$model->type[$i],array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('typeofglass[]',$model->typeofglass[$i],array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('vision[]',$model->vision[$i],array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('lunette[]',$model->lunette[$i],array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('interpupillarydistance[]',$model->interpupillarydistance[$i],array('style'=>'width:150px')); ?></td>
             	</tr>
        <?php endfor; ?>
		<tr>
    			<td><?php  echo CHtml::hiddenField('idinvoice[]',$_GET['idinvoice'],array('style'=>'width:90px','readonly'=>true)); ?></td>
                <td><?php echo CHtml::textField('eye[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('type[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('typeofglass[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('vision[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('lunette[]','',array('style'=>'width:150px')); ?></td>
                <td><?php echo CHtml::textField('interpupillarydistance[]','',array('style'=>'width:150px')); ?></td>
		</tr>
    <?php endif; ?>
	</tbody>
</table>
