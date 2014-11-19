<div class="form">



<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'members-form',
	'enableAjaxValidation' => false,
	'htmlOptions' => array(
        'enctype' => 'multipart/form-data',
    ),
));
?>


	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>
     <table width="80%">
     	<tr>
     		<td>
     	<div class="row">
		<?php echo $form->labelEx($model,'photo'); ?>
		<?php echo CHtml::activeFileField($model, 'photo'); ?> 
		<?php echo $form->error($model,'photo'); ?>
		</div><!-- row -->
		<?php if($model->isNewRecord!='1'){ ?>
	          <div class="row">
	                 <?php echo CHtml::image(Yii::app()->request->baseUrl.'/pictures/'.$model->photo,"photo",array("width"=>200)); ?>  
	          </div>
	    <?php } ?>
	</td>
     		<td>
               <div class="row">
		       <?php echo $form->labelEx($model,'firstname'); ?>
		       <?php echo $form->textField($model, 'firstname', array('maxlength' => 20)); ?>
		       <?php echo $form->error($model,'firstname'); ?>
		</div><!-- row -->
     		</td>
     	</tr>
     	<tr>
     		<td>
         <div class="row">
		<?php echo $form->labelEx($model,'middlename'); ?>
		<?php echo $form->textField($model, 'middlename', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'middlename'); ?>
		</div><!-- row -->
     		</td>
     		<td>
<div class="row">
		<?php echo $form->labelEx($model,'lastname'); ?>
		<?php echo $form->textField($model, 'lastname', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'lastname'); ?>
		</div><!-- row -->
     		</td>
     	</tr>
     	<tr>
     		<td>
<div class="row">
		<?php echo $form->labelEx($model,'dateofbirth'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'dateofbirth',
			'value' => $model->dateofbirth,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
		<?php echo $form->error($model,'dateofbirth'); ?>
		</div><!-- row -->
     		</td>
     		<td>
       <div class="row">
		<?php echo $form->labelEx($model,'sex'); ?>
		<?php echo $form->dropDownList($model,'sex',array('0'=>'Male','1'=>'Female'), array('prompt'=>'Select Gender')); ?>
		<?php echo $form->error($model,'sex'); ?>
		</div><!-- row -->
     		</td>
     	</tr>
     	<tr>
     		<td>
        <div class="row">
		<?php echo $form->labelEx($model,'type'); ?>
		<?php echo $form->dropDownList($model,'type',array('1'=>'Spouse','2'=>'Child'), array('prompt'=>'Select Category')); ?>
		<?php echo $form->error($model,'type'); ?>
		</div><!-- row -->
     		</td>
     		<td>
        <div class="row">
		<?php echo $form->labelEx($model,'Principal Member *'); ?>
		<?php echo $form->dropDownList($model, 'idmember', GxHtml::listDataEx(Members::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'idmember'); ?>
		</div><!-- row -->
     		</td>
     	</tr>
</table>
<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->