<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'ordonance-form',
	'enableAjaxValidation' => false,
));
?>
<table>
     <tr>
        <td colspan=5>
	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>
</td>
<tr>
  <tr> 
    <td>
		
		<?php echo $form->labelEx($model,'eye'); ?>
		<?php  echo $form->dropDownList($model,'eye',array('Droit / Right'=>'Droit / Right ','Gauche / Left'=>'Gauche / Left'), array('prompt'=>' Select Oeil')); ?>
        <?php echo $form->error($model,'eye'); ?>
		
     </td> 
     <td>
		
		<?php echo $form->labelEx($model,'type'); ?>
		<?php echo $form->dropDownList($model,'type',array('Sphere / Spherical','Cylindre / Cylindrical'=>'Cylindre / Cylindrical','Axe/Axis'=>'Axe/Axis'),array('prompt'=>' Select Type')); ?>               
		<?php echo $form->error($model,'type'); ?>
		
     </td>
     <td>
		
		<?php echo $form->labelEx($model,'typeofglass'); ?>
		<?php  echo $form->dropDownList($model,'typeofglass',array('Mineraux / Mineral'=>'Mineraux / Mineral','Clairs / Clears'=>'Clairs/Clears','Organiques/Organic'=>'Organiques/Organic','Photochromiques/Photo Chromic'=>'Photochromiques/Photo Chromic'), array('prompt'=>'Select Type'));
                        ?>
		<?php echo $form->error($model,'typeofglass'); ?>
		
     </td>
</tr>
<tr>

     <td>
		
		<?php echo $form->labelEx($model,'vision'); ?>
		<?php echo $form->textField($model, 'vision', array('maxlength' => 8)); ?>
		<?php echo $form->error($model,'vision'); ?>
		
     </td>
     <td>
		
		<?php echo $form->labelEx($model,'lunette'); ?>
		<?php echo $form->dropDownList($model,'lunette',array('Double foyers / Bifocal'=>'Double foyers / Bifocal','Progressifs / Progressive'=>'Progressifs / Progressive'), array('prompt'=>'Select Lunette'));
                        ?>
		<?php echo $form->error($model,'lunette'); ?>
		
     </td>
     <td>
		
		<?php echo $form->labelEx($model,'interpupillarydistance'); ?>
		<?php echo $form->textField($model, 'interpupillarydistance'); ?>
		<?php echo $form->error($model,'interpupillarydistance'); ?>
	
     </td>
    <?php echo $form->hiddenField($model, 'idinvoice',array('value'=>$_GET['idinvoice'] )); ?>
	
</tr>
<tr>

     <td>
<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->
</td>
</tr>
</table>
<table width = '98%'>
<tr>
	<td>
<?php 

$lunette = array('Double foyers / Bifocal'=>'Double foyers / Bifocal','Progressifs / Progressive'=>'Progressifs / Progressive');
$eye = array('Droit / Right'=>'Droit / Right ','Gauche / Left'=>'Gauche / Left');
$typeofglass = array('Mineraux / Mineral'=>'Mineraux / Mineral','Clairs / Clears'=>'Clairs/Clears','Organiques/Organic'=>'Organiques/Organic');
$type = array('Sphere / Spherical','Cylindre / Cylindrical'=>'Cylindre / Cylindrical','Axe/Axis'=>'Axe/Axis');
$this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'grid1',
	'dataProvider'=>$model->search(),
        'type'=>'striped bordered condensed',
        'template'=>'{summary}{pager}{items}{pager}',
       
	'columns'=>array(
		'id',
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'eye',
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'select',
                    'source' => $eye,
                    'url'      => $this->createUrl('ordonance/updateBooster'),
                                
                  ),
          ),
		      array( 
		          'class' => 'editable.EditableColumn',
                  'name' => 'type',
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'select',
                    'source' => $type,
                    'url'      => $this->createUrl('ordonance/updateBooster'),
        
                   
                  ),
          ),
		      array( 
          'class' => 'editable.EditableColumn',
                  'name' => 'typeofglass',
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'select',
                    'url'      => $this->createUrl('ordonance/updateBooster'),
                    'source' => $typeofglass,
              
                   
                  ),
          ),
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'vision',
            
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'text',
                    'url'      => $this->createUrl('ordonance/updateBooster'),
           
                   
                  ),
          ),
		array( 
		          'class' => 'editable.EditableColumn',
                  'name' => 'lunette',
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'select',
                    'url'      => $this->createUrl('ordonance/updateBooster'),
                  'source' => $lunette,
                  ),
          ),
		array( 
          'class' => 'editable.EditableColumn',
                  'name' => 'interpupillarydistance',
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'text',
                    'url'      => $this->createUrl('ordonance/updateBooster'),
      
                  ),
          ),
	
		
	),
)); 

?>
	</td>
</tr>

<tr>
	<td colspan = 2 align='right'>
<?php 
/*
$this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'grid2',
	'dataProvider'=>BillingDetails::model()->sum_invoice(),
        'type'=>'striped bordered condensed',
         'summaryText' => '', // 1st way
         'template' => '{items}{pager}', // 2nd way

	'columns'=>array(

		array(
				'name'=>'paid',
				'header'=>'You should pay this amount',
				'htmlOptions'=>array('style'=>'text-align: right;font-size:18px'),
		),
      
	),
));*/ ?>
	</td>
</tr>
</table>
