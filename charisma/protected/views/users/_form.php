<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'users-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'firstname'); ?>
		<?php echo $form->textField($model, 'firstname', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'firstname'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'middlename'); ?>
		<?php echo $form->textField($model, 'middlename', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'middlename'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'lastname'); ?>
		<?php echo $form->textField($model, 'lastname', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'lastname'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'username'); ?>
		<?php echo $form->textField($model, 'username', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'username'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'password'); ?>
		<?php echo $form->passwordField($model, 'password', array('maxlength' => 32)); ?>
		<?php echo $form->error($model,'password'); ?>
		</div><!-- row -->
		<!--
		<div class="row">
		<?php //echo $form->labelEx($model,'salt'); ?>
		<?php //echo $form->textField($model, 'salt', array('maxlength' => 32)); ?>
		<?php //echo $form->error($model,'salt'); ?>
		</div>
          -->
		<!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'groupe'); ?>
		<?php echo $form->dropDownList($model,'groupe',array('1'=>'Clerk Desk of Hospital','2'=>'Clerk Desk of Pharmacy','3'=>'MIS Accountant','4'=>'MIS Admin','5'=>'MIS Manager','6'=>'MIS Pharmacist'), array('prompt'=>'Select Group')); ?>
		<?php echo $form->error($model,'groupe'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'status'); ?>
		<?php echo $form->textField($model, 'status'); ?>
		<?php echo $form->error($model,'status'); ?>
		</div><!-- row -->

		<label><?php echo GxHtml::encode($model->getRelationLabel('hospitals')); ?></label>
		<?php echo $form->checkBoxList($model, 'hospitals', GxHtml::encodeEx(GxHtml::listDataEx(Hospital::model()->findAllAttributes(null, true)), false, true)); ?>

<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->