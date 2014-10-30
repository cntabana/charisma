<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'invoice-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<table width='100%'>
			<tr>
				 <td>
				  <div class="row">
		           <?php echo $form->labelEx($model,'idmember'); ?>
		           <?php echo $form->dropDownList($model, 'idmember', GxHtml::listDataEx(Members::model()->findAllAttributes(null, true))); ?>
		           <?php echo $form->error($model,'idmember'); ?>
		           </div><!-- row -->
				 </td>
				 <td>
				 	<div class="row">
		            <?php echo $form->labelEx($model,'type'); ?>
		            <?php 
                       if(Yii::app()->session['group'] == 4 || Yii::app()->session['group'] == 5 || Yii::app()->session['group'] == 3)
		               echo $form->dropDownList($model,'type',array('1'=>'Analyse','2'=>'Traitement','3'=>'Lunette','4'=>'Pharmacy'), array('prompt'=>'Select Type'));
                       else if(Yii::app()->session['group'] == 1)
                       echo $form->dropDownList($model,'type',array('1'=>'Analyse','2'=>'Traitement','3'=>'Lunette'), array('prompt'=>'Select Type'));
                       else
						echo $form->textField($model, 'type',array('value'=>4)); 
		                ?>
		               
		               
		            <?php echo $form->error($model,'type'); ?>
		            </div><!-- row -->
				 </td>
				 <td>
				 	<div class="row">
		<?php echo $form->labelEx($model,'date'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'date',
			'value' => $model->date,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
		<?php echo $form->error($model,'date'); ?>
		</div><!-- row -->
				 </td>
			</tr>
				<tr>
				 <td>	
				 	<div class="row">
		<?php echo $form->labelEx($model,'idhospital'); ?>
		<?php echo $form->dropDownList($model, 'idhospital', GxHtml::listDataEx(Hospital::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'idhospital'); ?>
		</div><!-- row -->
				 </td>
				 <td>
				 	<div class="row">
		<?php echo $form->labelEx($model,'status'); ?>
		<?php echo $form->textField($model, 'status'); ?>
		<?php echo $form->error($model,'status'); ?>
		</div><!-- row -->
				 </td>
				 <td>
				 	&nbsp;
				 </td>
			</tr>
			<tr><td colspan=3 align='left'><?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form --><td/></tr>

		</table>
		
	