<table class="appendo-gii" id="<?php echo $id ?>" width = '70%'>
	
	<thead>
		<tr>
			<th>.</th>
            <th>Medical</th>
            <th>Price</th>
            <th>Quantity</th>
		</tr>
	</thead>
	<tbody>
    <?php 
$model = new BillingDetails;

    if ($model->idmedical == null): ?>
		<tr>
	
            <td><?php  echo CHtml::hiddenField('idinvoice[]',$_GET['idinvoice'],array('style'=>'width:90px','readonly'=>true)); ?></td>
            <td><?php  echo CHtml::dropDownList('idmedical[]','',
                        Chtml::listData(Traitement::model()->findAllByAttributes(array('type'=>$_REQUEST['type'],'transfer'=>1)), 'id', 'medical_act'),
                        array('empty'=>'Select Traitment'));

            ?></td>
             <td><?php echo CHtml::textField('price[]','',array('style'=>'width:150px')); ?></td>
            <td><?php echo CHtml::textField('quantity[]','',array('style'=>'width:150px')); ?></td>
		</tr>
    <?php else: ?>
        <?php for($i = 0; $i < sizeof($model->idmedical); ++$i): ?>
    		<tr>
    			<td><?php echo CHtml::textField('idinvoice[]',$model->idinvoice[$i],array('style'=>'width:20px')); ?></td>
                <td><?php //echo CHtml::textField('idmedical[]',$model->idmedical[$i],array('style'=>'width:90px')); ?>
                    <?php  echo CHtml::dropDownList( 'idmedical[]',$model->idmedical[$i],
                         Chtml::listData(Traitement::model()->findAllByAttributes(array('type'=>$_REQUEST['type'],'transfer'=>1)), 'id', 'medical_act'),
                        array('empty'=>'Select Traitment'));

            ?>
                </td>
                <td><?php echo CHtml::textField('price[]',$model->price[$i],array('style'=>'width:90px')); ?></td>
                <td><?php echo CHtml::textField('quantity[]',$model->quantity[$i],array('style'=>'width:310px')); ?></td>
    		</tr>
        <?php endfor; ?>
		<tr>
			<td><?php echo CHtml::textField('idinvoice[]','',array('style'=>'width:20px')); ?></td>
            <td><?php  echo CHtml::dropDownList('idmedical[]',$model->idmedical[$i],
                        Chtml::listData(Traitement::model()->findAllByAttributes(array('type'=>$_REQUEST['type'],'transfer'=>1)), 'id', 'medical_act'),
                        array('empty'=>'Select Traitment'));

            ?></td>
            <td><?php echo CHtml::textField('price[]','',array('style'=>'width:90px')); ?></td>
            <td><?php echo CHtml::textField('quantity[]','',array('style'=>'width:90px')); ?></td>
		</tr>
    <?php endif; ?>
	</tbody>
</table>
