<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'hospital-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'hopitalName'); ?>
		<?php echo $form->textField($model, 'hopitalName', array('maxlength' => 50)); ?>
		<?php echo $form->error($model,'hopitalName'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'address'); ?>
		<?php echo $form->textField($model, 'address', array('maxlength' => 30)); ?>
		<?php echo $form->error($model,'address'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'type'); ?>
		<?php echo $form->dropDownList($model,'type',array('0'=>'Hospital','1'=>'Pharmacy'), array('prompt'=>'Select Type')); ?>
		<?php echo $form->error($model,'type'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'iduser'); ?>
		<?php echo $form->dropDownList($model, 'iduser', GxHtml::listDataEx(Users::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'iduser'); ?>
		</div><!-- row -->

		<label><?php echo GxHtml::encode($model->getRelationLabel('invoices')); ?></label>
		<?php echo $form->checkBoxList($model, 'invoices', GxHtml::encodeEx(GxHtml::listDataEx(Invoice::model()->findAllAttributes(null, true)), false, true)); ?>

<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->