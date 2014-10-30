<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'price-history-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'iddrug'); ?>
		<?php echo $form->dropDownList($model, 'iddrug', GxHtml::listDataEx(Drugs::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'iddrug'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'ancient_price'); ?>
		<?php echo $form->textField($model, 'ancient_price'); ?>
		<?php echo $form->error($model,'ancient_price'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'new_price'); ?>
		<?php echo $form->textField($model, 'new_price'); ?>
		<?php echo $form->error($model,'new_price'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'old_changedate'); ?>
		<?php echo $form->textField($model, 'old_changedate', array('maxlength' => 50)); ?>
		<?php echo $form->error($model,'old_changedate'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'changedate'); ?>
		<?php echo $form->textField($model, 'changedate'); ?>
		<?php echo $form->error($model,'changedate'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'userid'); ?>
		<?php echo $form->dropDownList($model, 'userid', GxHtml::listDataEx(Users::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'userid'); ?>
		</div><!-- row -->


<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->