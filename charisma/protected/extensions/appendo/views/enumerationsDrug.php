<table class="appendo-gii" id="<?php echo $id ?>" width = '70%'>
	
	<thead>
		<tr>
			<th>.</th>
            <th>Medical</th>
            <th>Quantity</th>
		</tr>
	</thead>
	<tbody>
    <?php 
$model = new BillingDrug;

    if ($model->iddrug == null): ?>
		<tr>
	
            <td><?php  echo CHtml::hiddenField('idinvoice[]',$_GET['idinvoice'],array('style'=>'width:90px','readonly'=>true)); ?></td>
            <td><?php  echo CHtml::dropDownList('iddrug[]','',
                        Chtml::listData(Drugs::model()->findAllByAttributes(array('special'=>1,'availability'=>1)), 'id', 'drug'),
                        array('empty'=>'Select Drug'));

            ?></td>
            <td><?php echo CHtml::textField('quantity[]','',array('style'=>'width:150px')); ?></td>
		</tr>
    <?php else: ?>
        <?php for($i = 0; $i < sizeof($model->iddrug); ++$i): ?>
    		<tr>
    			<td><?php echo CHtml::textField('idinvoice[]',$model->idinvoice[$i],array('style'=>'width:20px')); ?></td>
                <td>
                    <?php  echo CHtml::dropDownList( 'iddrug[]',$model->iddrug[$i],
                         Chtml::listData(Drugs::model()->findAllByAttributes(array('special'=>1,'availability'=>1)), 'id', 'drug'),
                        array('empty'=>'Select Drug'));

            ?>
                </td>
                   <td><?php echo CHtml::textField('quantity[]',$model->quantity[$i],array('style'=>'width:310px')); ?></td>
    		</tr>
        <?php endfor; ?>
		<tr>
			<td><?php echo CHtml::textField('idinvoice[]','',array('style'=>'width:20px')); ?></td>
            <td><?php  echo CHtml::dropDownList('iddrug[]',$model->iddrug[$i],
                        Chtml::listData(Drugs::model()->findAllByAttributes(array('special'=>1,'availability'=>1)), 'id', 'drug'),
                        array('empty'=>'Select Drug'));

            ?></td>
            <td><?php echo CHtml::textField('price[]','',array('style'=>'width:90px')); ?></td>
            <td><?php echo CHtml::textField('quantity[]','',array('style'=>'width:90px')); ?></td>
		</tr>
    <?php endif; ?>
	</tbody>
</table>
