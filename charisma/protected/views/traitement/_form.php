<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'traitement-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'medical_act'); ?>
		<?php echo $form->textField($model, 'medical_act', array('maxlength' => 50)); ?>
		<?php echo $form->error($model,'medical_act'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'idservice'); ?>
		<?php echo $form->dropDownList($model, 'idservice', GxHtml::listDataEx(Service::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'idservice'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'type'); ?>
		<?php echo $form->dropDownList($model,'type',array('1'=>'Analyse','2'=>'Traitement'), array('prompt'=>'Select Type')); ?>
		<?php echo $form->error($model,'type'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'transfer'); ?>
		<?php echo $form->textField($model, 'transfer'); ?>
		<?php echo $form->error($model,'transfer'); ?>
		</div><!-- row -->

		

<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->